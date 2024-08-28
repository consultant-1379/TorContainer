define([
    'Titan',
    'template!./menu/menu.html'
], function (Titan, topMenuTemplate) {
    return Titan.Application.extend({

        AFTER_LOAD_EVENT: 'Container.AfterLoadEvent',

        start: function () {
            var Model = Titan.Model.extend({
                urlRoot: 'apps.json'
            });

            var model = new Model();
            model.on('change', this.onAppListLoaded, this);
            model.fetch();
        },

        onAppListLoaded: function (model) {
            var deps = [],
                self = this;

            this.apps = model.get('apps');
            this.apps.forEach(function (app) {
                deps.push(app['namespace'] + '/' + app['script']);
            });

            require(deps, function () {
                self.onDepsLoad.apply(self, arguments);     // TODO: replace with underscore bind
            });
        },

        onDepsLoad: function () {
            var list = Titan.utils.getListFromArguments(arguments, 0),
                container = this.container,
                option = list.length > 1 ? {silent: true} : {};

            list.forEach(function (Application) {
                var app = new Application({
                    container: container
                });
                this.eventBus.trigger(this.AFTER_LOAD_EVENT, app);
                app.start(option);
            }, this);

            var TopMenu = Titan.View.extend({
                template: topMenuTemplate,
                apps: this.apps,
                init:function(){
                    this.signOut();
                },
                location:"/logout",
                message:"Are you sure you want to Sign Out?",
                signOut:function(){
                    var message=this.message;
                    var location=this.location;
                    this.signOutButton.on('click', function(){
                        var conf=confirm(message);
                        if(conf===true){
                            window.location=location;
                        }
                    });
                }
            });
            var topMenu = new TopMenu();

            var MenuApp = Titan.Application.extend({
                start: function () {
                    this.container.addWidget(topMenu);
                }
            });


			//application that renders topMenu
            var menuApp = new MenuApp({
                container: '#TopMenu'
            });
            menuApp.start();


        }

    });

});