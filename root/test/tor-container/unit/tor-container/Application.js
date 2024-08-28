define(['tor-container/Application'], function (Container) {

    describe('Container', function () {

        it('loads apps.json and starts application', function () {
            var apps = [];

            runs(function () {
                var container = new Container({
                    container: '#Container'
                });
                container.eventBus.on(container.AFTER_LOAD_EVENT, function (app) {
                    apps.push(app);
                });
                container.start();
            });

            waitsFor(function () {
                return apps.length > 1;
            });

            runs(function () {
                expect(apps.length).toBe(2);
            });

        });

    });

});
