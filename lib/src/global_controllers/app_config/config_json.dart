//
//
// import '../database_controller.dart';
//
// String jsonResponse = '''
// {
//     "success": true,
//     "data": [
//         {
//             "id": 1,
//             "user_id": "2",
//             "title": "Working API",
//             "app_json": {
//                 "user": {
//                     "email": "muhammad.hamza@gmail.com",
//                     "name": "muhammad.hamza",
//                     "token": "10|IKRzdv6Q2FRcpLcSAg7XaA1jiO1YAyVCe58DUGoQ",
//                     "access_token": "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"
//                 },
//                 "widgets": {
//                     "widget": [
//                         {
//                             "id": "1175",
//                             "selected": false,
//                             "type": "search",
//                             "settings": {
//                                 "border": 0
//                             }
//                         },
//                         {
//                             "id": "4042",
//                             "selected": false,
//                             "type": "divider",
//                             "settings": {
//                                 "type": 2,
//                                 "custom": []
//                             }
//                         },
//                         {
//                             "id": "5362",
//                             "selected": false,
//                             "type": "title",
//                             "settings": {
//                                 "title": "Welcome To Tapify",
//                                 "titleAlignment": "center",
//                                 "titleSize": "large"
//                             }
//                         },
//                         {
//                             "id": "6461",
//                             "selected": false,
//                             "type": "timer",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Death Timer",
//                                 "titleAlignment": "center",
//                                 "titleSize": "small",
//                                 "subtitle": "SubTitle here",
//                                 "isSubTitleHidden": false,
//                                 "startDate": "2023-07-04T14:23",
//                                 "endDate": "2023-07-05T15:23",
//                                 "timezone": "Europe/London",
//                                 "timerColor": "#000",
//                                 "showOnProductList": false,
//                                 "margin": false,
//                                 "disableInteraction": false
//                             }
//                         },
//                         {
//                             "id": "4792",
//                             "selected": false,
//                             "type": "product",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "displayType": "normal",
//                                 "viewType": "small",
//                                 "margin": false,
//                                 "contentMargin": false,
//                                 "hideContentTitle": false,
//                                 "hideContentPrice": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 8367111799096,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105507640,
//                                             "path": "https://images.unsplash.com/photo-1606152421802-db97b9c7a11b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=874&q=80"
//                                         },
//                                         {
//                                             "id": 8367105376568,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105245496,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105311032,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105278264,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105638712,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105605944,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105343800,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105540408,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "automatic",
//                                     "showWarning": false,
//                                     "dataType": "product",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "5601",
//                             "selected": false,
//                             "type": "gallery",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "displayType": "normal",
//                                 "viewType": "small",
//                                 "margin": false,
//                                 "contentMargin": false,
//                                 "hideContentTitle": false,
//                                 "hideContentPrice": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 8367111799096,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105507640,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105376568,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105245496,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "manual",
//                                     "showWarning": true,
//                                     "dataType": "product",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "2697",
//                             "selected": false,
//                             "type": "carousel",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "right",
//                                 "titleSize": "medium",
//                                 "displayType": "vertical",
//                                 "viewType": "small",
//                                 "margin": false,
//                                 "hideContentTitle": true,
//                                 "hideContentPrice": false,
//                                 "contentMargin": true,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 429573636408,
//                                             "path": null
//                                         },{
//                                             "id": 449658519864,
//                                             "path": null
//                                         },{
//                                             "id": 449658618168,
//                                             "path": null
//                                         },{
//                                             "id": 449658650936,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "manual",
//                                     "showWarning": true,
//                                     "dataType": "collection",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "7308",
//                             "selected": false,
//                             "type": "image",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "titleSize": "small",
//                                 "displayType": "vertical",
//                                 "titlePosition": "hidden",
//                                 "viewType": "small",
//                                 "margin": true,
//                                 "contentMargin": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": "web-url602369.8760739007",
//                                             "path": "https://images.unsplash.com/photo-1606151760469-1d82108f80ed?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=874&q=80",
//                                             "selected": false,
//                                             "title": "Your Title",
//                                             "web_url": "https://${AdminHomeLogic.to.browsingShopDomain.value}/",
//                                             "imageName": "AstroNvim.png"
//                                         },
//                                         {
//                                             "id": "web-url830299.1009565295",
//                                             "path": "https://images.unsplash.com/photo-1612956946912-b2d8e5fd65a8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=874&q=80",
//                                             "selected": true,
//                                             "title": "Your Title",
//                                             "web_url": "https://${AdminHomeLogic.to.browsingShopDomain.value}/products/audi-rs3-8ycarbon-rear-diffuser",
//                                             "imageName": "Group 20744 (4).svg"
//                                         },
//                                         {
//                                             "id": "web-url329935.9667145953",
//                                             "path": "https://images.unsplash.com/photo-1617195920950-1145bf9a9c72?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=465&q=80",
//                                             "selected": false,
//                                             "title": "Your Title",
//                                             "web_url": "https://www.google.com",
//                                             "imageName": "hero3.png"
//                                         },
//                                         {
//                                             "id": "web-url817695.1240374579",
//                                             "path": "https://images.unsplash.com/photo-1616422285623-13ff0162193c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=431&q=80",
//                                             "selected": false,
//                                             "title": "Your Title",
//                                             "web_url": "https://www.google.com",
//                                             "imageName": "Combo.png"
//                                         }
//                                     ],
//                                     "productType": "manual",
//                                     "showWarning": false,
//                                     "dataType": "web-url",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "9911",
//                             "selected": false,
//                             "type": "video",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "video": "https://dnd.noumanengr.com/videos/WV4e2DTLkhDZosStrqEXrlF9vI7gVUHymUxnyc9h.mp4",
//                                 "thumbnail": [],
//                                 "videoDisplayType": "fit",
//                                 "autoPlay": true,
//                                 "controlBar": false,
//                                 "mute": true,
//                                 "restart": true,
//                                 "loop": true,
//                                 "margin": false
//                             }
//                         },
//                         {
//                             "id": "6185",
//                             "selected": false,
//                             "type": "slideShow",
//                             "settings": {
//                                 "isTitleHidden": true,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "displayType": "normal",
//                                 "titleSize": "small",
//                                 "titlePosition": "center",
//                                 "viewType": "small",
//                                 "margin": true,
//                                 "contentMargin": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 8367111799096,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105507640,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "manual",
//                                     "showWarning": true,
//                                     "dataType": "product",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "790",
//                             "selected": false,
//                             "type": "slider",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "titlePosition": "bottom",
//                                 "margin": false,
//                                 "contentMargin": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 8367105376568,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367111799096,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105245496,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105278264,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "manual",
//                                     "showWarning": true,
//                                     "dataType": "product",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 },
//                                 "displayType": "normal"
//                             }
//                         },
//                         {
//                             "id": "4810",
//                             "selected": false,
//                             "type": "productByTags",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "displayType": "normal",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "tagQuantity": 4,
//                                 "viewType": "large",
//                                 "showAddToCart": false,
//                                 "tagsView": "small",
//                                 "hideBorders": false,
//                                 "margin": true,
//                                 "textColor": "#000",
//                                 "backgroundColor": "#ffffff",
//                                 "contentMargin": true,
//                                 "hideContentTitle": false,
//                                 "hideContentPrice": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 429573636408,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "automatic",
//                                     "showWarning": true,
//                                     "dataType": "collection",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "7442",
//                             "selected": false,
//                             "type": "grid",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Title",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "displayType": "normal",
//                                 "viewType": "large",
//                                 "showAddToCart": false,
//                                 "hideBorders": false,
//                                 "margin": true,
//                                 "contentMargin": true,
//                                 "hideContentTitle": false,
//                                 "hideContentPrice": false,
//                                 "disableInteraction": false,
//                                 "metadata": {
//                                     "automaticProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "sort": {
//                                             "id": "manual",
//                                             "title": "Featured"
//                                         }
//                                     },
//                                     "data": [
//                                         {
//                                             "id": 8367111799096,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105507640,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105376568,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105245496,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105311032,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105278264,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105638712,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105605944,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105343800,
//                                             "path": null
//                                         },
//                                         {
//                                             "id": 8367105540408,
//                                             "path": null
//                                         }
//                                     ],
//                                     "productType": "automatic",
//                                     "showWarning": false,
//                                     "dataType": "product",
//                                     "id": null,
//                                     "manualProducts": {
//                                         "collection": {
//                                             "id": null,
//                                             "title": null
//                                         },
//                                         "limit": {
//                                             "id": 10,
//                                             "title": "10"
//                                         },
//                                         "status": {
//                                             "id": "all",
//                                             "title": "All"
//                                         },
//                                         "search": null
//                                     }
//                                 }
//                             }
//                         },
//                         {
//                             "id": "6905",
//                             "selected": false,
//                             "type": "discount",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Your Latest Discount",
//                                 "displayType": "normal",
//                                 "titlePosition": "center",
//                                 "margin": false,
//                                 "image": null,
//                                 "disableInteraction": false
//                             }
//                         }
//                     ],
//                     "menuItems": [
//                         {
//                             "id": "7341",
//                             "selected": false,
//                             "type": "recently viewed",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Recently Viewed",
//                                 "titleAlignment": "right",
//                                 "titleSize": "medium",
//                                 "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                 "icon": "show"
//                             }
//                         },
//                         {
//                             "id": "1300",
//                             "selected": false,
//                             "type": "sub collection",
//                             "icon": "/v2-icons/menu-icons/sub_collection.svg",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Sub Collection",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                 "icon": "hide"
//                             },
//                             "title": "Sub Collection"
//                         },
//                         {
//                             "id": "126",
//                             "selected": false,
//                             "type": "my account",
//                             "icon": "/v2-icons/menu-icons/my_account.svg",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "My s",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                 "icon": "show"
//                             },
//                             "title": "My Account"
//                         },
//                         {
//                             "id": "7883",
//                             "selected": true,
//                             "type": "collapsable menu",
//                             "icon": "/v2-icons/menu-icons/collapsable_menu.svg",
//                             "settings": {
//                                 "isTitleHidden": false,
//                                 "title": "Menu",
//                                 "titleAlignment": "left",
//                                 "titleSize": "medium",
//                                 "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                 "icon": "show"
//                             },
//                             "title": "Collapsable Menu",
//                             "subItems": [
//                                 {
//                                     "id": "1082",
//                                     "selected": false,
//                                     "type": "web url",
//                                     "settings": {
//                                         "isTitleHidden": false,
//                                         "title": "Web URL",
//                                         "titleAlignment": "left",
//                                         "titleSize": "medium",
//                                         "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                         "icon": "show"
//                                     }
//                                 },
//                                 {
//                                     "id": "44",
//                                     "selected": true,
//                                     "type": "mobile_app_privacy_policy",
//                                     "settings": {
//                                         "isTitleHidden": false,
//                                         "title": "Mobile app",
//                                         "titleAlignment": "right",
//                                         "titleSize": "medium",
//                                         "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                         "icon": "show"
//                                     }
//                                 },
//                                 {
//                                     "id": "713",
//                                     "selected": false,
//                                     "type": "news",
//                                     "settings": {
//                                         "isTitleHidden": false,
//                                         "title": "News",
//                                         "titleAlignment": "left",
//                                         "titleSize": "medium",
//                                         "path": "https://dnd.noumanengr.com/gallery/1688721428_ao01.svg",
//                                         "icon": "show"
//                                     }
//                                 }
//                             ]
//                         }
//                     ],
//                     "editbar": true
//                 },
//                 "settings": {
//                     "appSettings": {
//                         "storeSetting": {
//                             "displaySoldoutInSearch": false,
//                             "quickAddInProduct": false,
//                             "allowsDiscountCodes": false,
//                             "allowGiftCards": false,
//                             "allowMultiCurrency": false,
//                             "pushNotification": null
//                         },
//                         "customerAccount": {
//                             "accountCreation": false,
//                             "checkAccountCreation": "Disabled:"
//                         },
//                         "cartAndCheckout": {
//                             "displaySoldoutInSearch": false,
//                             "quickAddInProduct": false,
//                             "allowsDiscountCodes": false,
//                             "allowGiftCards": false,
//                             "allowMultiCurrency": false,
//                             "pushNotification": null
//                         }
//                     },
//                     "customization": {
//                         "cardGiftPopup": {
//                             "image": null,
//                             "cardGiftMessage": null
//                         },
//                         "discountCodePopup": {
//                             "image": null,
//                             "cardGiftMessage": null
//                         },
//                         "favoritePopup": {
//                             "image": null,
//                             "cardGiftMessage": null
//                         },
//                         "forgatPasswordPopup": {
//                             "image": null,
//                             "cardGiftMessage": null
//                         },
//                         "productImage": {
//                             "chooseImage": "square"
//                         },
//                         "filters": {
//                             "sectionName": null,
//                             "sectionTitleTag": [
//                                 {
//                                     "tags": null,
//                                     "title": null
//                                 },
//                                 {
//                                     "tags": null,
//                                     "title": null
//                                 },
//                                 {
//                                     "tags": null,
//                                     "title": null
//                                 },
//                                 {
//                                     "tags": null,
//                                     "title": null
//                                 }
//                             ]
//                         },
//                         "metafield": [
//                             {
//                                 "spaceName": null,
//                                 "key": null
//                             },
//                             {
//                                 "spaceName": null,
//                                 "key": null
//                             },
//                             {
//                                 "spaceName": null,
//                                 "key": null
//                             }
//                         ]
//                     },
//                     "dynamicProducts": {
//                         "dynamicProduct": {
//                             "setProductBaseOnMatchingImage": false,
//                             "setCollection": "Shirt",
//                             "imageTags": null,
//                             "setProductBaseOnLowerCost": false,
//                             "setCollectionBaseOnLowerCost": "Shirt",
//                             "productPageImageFilter": false
//                         },
//                         "rangePrice": {
//                             "showProductPriceRange": false
//                         }
//                     },
//                     "productsBadges": [],
//                     "accountAndBilling": [],
//                     "appListing": {
//                         "branding": {
//                             "appIcon": null,
//                             "splashIcon": null,
//                             "placeholderImage": null
//                         },
//                         "listing": {
//                             "apptitle": null,
//                             "appSubTitle": null,
//                             "primaryCatagory": null,
//                             "secoundryCatagory": null,
//                             "keywords": [],
//                             "description": null
//                         },
//                         "bussnessInformation": {
//                             "marketingUrl": null,
//                             "supportUrl": null,
//                             "privacyUrl": null
//                         }
//                     }
//                 },
//                 "color": {
//                     "colorSettings": {
//                         "primaryColor": "#0088F5",
//                         "secondaryColor": "#FFFFFF",
//                         "chatColor": "#CA0022",
//                         "cartColor": "#469E9B",
//                         "menuIcon": 0,
//                         "cartIcon": 1,
//                         "chatIcon": 0
//                     }
//                 }
//             },
//             "created_at": "2023-07-04T10:51:46.000000Z",
//             "updated_at": "2023-07-04T10:51:46.000000Z"
//         }
//     ],
//     "message": "Structure list get successfully."
// }
// ''';
