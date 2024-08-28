define([
    'Titan'
], function (Titan) {

    var View = Titan.View.extend({

    });

    var Presenter = Titan.Presenter.extend({
        View: View,
        onPlaceChanged: function() {
            console.log('app-test2 started')
        }
    });

    var Place = Titan.Place.extend({
        name: 'app-test2',
        pattern: 'app-test2',
        Presenter: Presenter,
        fn: 'onPlaceChanged',
        defaultPlace: true
    });
    return Titan.Application.extend({

        places: [Place]

    });

});
