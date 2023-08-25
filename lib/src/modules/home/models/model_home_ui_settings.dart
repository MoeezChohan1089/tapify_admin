class ModelHomeUISettings {
  dynamic listOfWidgetsSettings;

  ModelHomeUISettings({required this.listOfWidgetsSettings});
}

List<ModelHomeUISettings> dummyHomeData = [
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "search",
    "settings": {"border": 1}
  }),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "divider",
    "settings": {"type": 2}
  }),
  ModelHomeUISettings(
      listOfWidgetsSettings: {
    "type": "marquee",
    "settings": {
      "title": 'Marquee text show here',
      "titleAlignment": 'right',
      "titleSize": 'small',
      "textColor": '#ffffff',
      "backgroundColor": '#000',
      "margin": false,
      "contentMargin": false,
      "hideContentTitle": false,
      "disableInteraction": false
    }
  }),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "product",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title ',
      "titleAlignment": 'left',
      "titleSize": 'small',
      "displayType": 'normal',
      "viewType": 'small',
      "margin": false,
      "contentMargin": false,
      "hideContentTitle": false,
      "hideContentPrice": false,
      "disableInteraction": false,
      "metadata": {
        "id": "1516",
        "data": [
          {"id": 8367111799096},
          {"id": 8367113011512},
          {"id": 8367111045432}
        ]
      }
    }
  }),

  //---- title
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "title",
    "settings": { "title": 'Title', "titleAlignment": 'center', "titleSize": 'medium' }
  }
  ),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "timer",
    "settings": {
      "isTitleHidden": true,
      "title": 'Your Title',
      "titleAlignment": 'center',
      "titleSize": 'small',
      "subtitle": 'SubTitle here',
      "isSubTitleHidden": true,
      "startDate": 0,
      "endDate": 0,
      "timezone": '',
      "timerColor": '#000',
      "showOnProductList": false,
      "margin": false,
      "disableInteraction": false
    }
  }),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "gallery",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title ',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "displayType": 'normal',
      "viewType": 'small',
      "margin": false,
      "contentMargin": false,
      "hideContentTitle": false,
      "hideContentPrice": false,
      "disableInteraction": false,
      "metadata": {
        "id": "1516",
        "data": [
          {"id": 8367110652216},
          {"id": 8367111045432}
        ]
      }
    }
  }),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "category",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title ',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "displayType": 'normal',
      "viewType": 'small',
      "margin": false,
      "contentMargin": false,
      "hideContentTitle": false,
      "disableInteraction": false,
      "metadata": {}
    }
  }),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "carousel",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "displayType": 'normal',
      "viewType": 'small',
      "margin": false,
      "hideContentTitle": false,
      "contentMargin": false,
      "disableInteraction": false,
      "metadata": {}
    },
  }),
  ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "image",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "displayType": 'normal',
      "viewType": 'small',
      "margin": false,
      "contentMargin": false,
      "disableInteraction": false,
      "metadata": {}
    },
  }), ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "slideShow",
    "settings": {
      "isTitleHidden": true,
      "title": 'Your Title',
      "titleAlignment": 'left',
      "displayType": 'normal',
      "titleSize": 'small',
      "titlePosition": 'center',
      "viewType": 'small',
      "margin": false,
      "contentMargin": false,
      "disableInteraction": false,
      "metadata": {}
    },
  }),ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "video",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "video": 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      "thumbnail": {},
      "videoDisplayType": 'fit',
      "autoPlay": false,
      "controlBar": false,
      "mute": false,
      "restart": false,
      "loop": false,
      "margin": false
    },
  }),ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "slider",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "titlePosition": 'center',
      "margin": false,
      "contentMargin": false,
      "disableInteraction": false,
      "metadata": {}
    },
  }),ModelHomeUISettings(listOfWidgetsSettings: {
    "type": "grid",
    "settings": {
      "isTitleHidden": false,
      "title": 'Your Title',
      "titleAlignment": 'left',
      "titleSize": 'medium',
      "displayType": 'normal',
      "viewType": 'small',
      "showAddToCart": false,
      "hideBorders": false,
      "margin": false,
      "contentMargin": false,
      "hideContentTitle": false,
      "hideContentPrice": false,
      "disableInteraction": false,
      "metadata": {}
    },
  }),
];