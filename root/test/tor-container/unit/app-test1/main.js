define([
    'Titan'
], function (Titan) {

    var View = Titan.View.extend({

    });

    var Presenter = Titan.Presenter.extend({
        View: View,
        onPlaceChanged: function() {
            console.log('app-test1 started')
        }
    });

    var Place = Titan.Place.extend({
        name: 'app-test1',
        pattern: 'app-test1',
        Presenter: Presenter,
        fn: 'onPlaceChanged',
        defaultPlace: true
    });

    return Titan.Application.extend({

        places: [Place]

    });

});
