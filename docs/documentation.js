// FUNCTIONS

/**
 * @func ironsource_init
 * @desc This function initialises the ironSource SDK with the app key. This app key should be provided through the extensions panel.
 * @func_end
 */
function ironsource_init() {}

/** 
 * @func ironsource_banner_init
 * @desc This function initialises the ironSource SDK for the Banner ad unit.
 * @event social
 * @member {string} type The value `"ironsource_banner_init"`
 * @event_end
 * @func_end
 */
function ironsource_banner_init() {}

/** 
 * @func ironsource_set_user
 * @desc Set the UserID before the init request, to make sure you avoid any data losses, related to the user. User unique identifier, with up to 64 alphanumeric characters.
 * @param {string} user_id User a unique identifier, with up to 64 alphanumeric characters.
 * @func_end
 */
function ironsource_set_user(user_id) {}

/** 
 * @func ironsource_add_impression_data_listener
 * @desc 
 * @event social
 * @member {string} type The value `"ironsource_add_impression_data_listener"`
 * @member {string} platform value: `"IronSource`"
 * @member {string} currency  value: `"USD`"
 * @member {real} revenue The revenue generated for the impression (USD). The revenue value is either estimated or exact, according to the precision (see precision field description)	
 * @member {string} instance_id Identifier per network, this includes the ad network’s. instanceID/placement/zone/etc.	
 * @member {string} instance_name The ad network instance name as defined on the platform. For bidding sources, the instance name will be ‘Bidding’	
 * @member {string} auction_id Unique identifier for the auction
 * @member {string} ad_network The ad network name that served the ad	
 * @member {string} placement The placement the user is related to	
 * @member {string} ad_unit The ad unit displayed (Rewarded Video/Interstitial/Banner)	
 * @event_end
 * @func_end
 */
function ironsource_add_impression_data_listener() {}

/** 
 * @func ironsource_banner_create
 * @desc Creates and displays a banner ad with the specified placement, size and position.
 * @param {string} placement_name The name of the ad placement.
 * @param {constant.BannerSize} size The size of the banner ad.
 * @param {boolean} bottom The position of the banner ad (`false`: top, `true`: bottom).
 * 
 * @event social
 * @desc If the banner loaded successfully:
 * @member {string} type The value `"ironsource_banner_loaded"`
 * @event_end
 * 
 * @event social 
 * @desc If the banner was clicked:
 * @member {string} type The value `"ironsource_banner_clicked"`
 * @event_end
 * 
 * @event social
 * @desc If the banner was presented:
 * @member {string} type The value `"ironsource_banner_presented"`
 * @event_end
 * 
 * @event social 
 * @desc If the banner was dismissed:
 * @member {string} type The value `"ironsource_banner_dismissed"`
 * @event_end
 * 
 * @event social 
 * @desc If the application was left due to banner interaction:
 * @member {string} type The value `"ironsource_banner_left_application"`
 * @event_end
 * 
 * @event social
 * @desc If the banner failed to load:
 * @member {string} type The value `"ironsource_banner_load_failed"`
 * @member {string} error The error message.
 * @event_end
 * 
 * @func_end
 */
function ironsource_banner_create() {}

/** 
 * @func ironsource_banner_move
 * @desc Moves the banner ad to the top or bottom of the screen based on the input value.
 * @param {boolean} bottom The position of the banner ad (`false`: top, `true`: bottom).
 * @func_end
 */
function ironsource_banner_move() {}

/** 
 * @func ironsource_banner_show
 * @desc Makes the banner ad visible if it exists.
 * @func_end
 */
function ironsource_banner_show() {}

/** 
 * @func ironsource_banner_hide
 * @desc Hides the banner ad if it exists.
 * @func_end
 */
function ironsource_banner_hide() {}

/** 
 * @func ironsource_banner_remove
 * @desc Removes and destroys the banner ad and its layout if they exist.
 * @func_end
 */
function ironsource_banner_remove() {}

/** 
 * @func ironsource_banner_get_width
 * @desc Returns the width of the banner ad.
 * @return {real}
 * @func_end
 */
function ironsource_banner_get_width() {}

/** 
 * @func ironsource_banner_get_height
 * @desc Returns the height of the banner ad.
 * @return {real}
 * @func_end
 */
function ironsource_banner_get_height() {}

/** 
 * @func ironsource_interstitial_init
 * @desc This function initialises the ironSource SDK for the Interstitial ad unit.
 * @event social
 * @member {string} type The value `"ironsource_interstitial_init"`
 * @event_end
 * @func_end
 */
function ironsource_interstitial_init() {}

/** 
 * @func ironsource_interstitial_load
 * @desc Loads an interstitial ad.
 *
 * @event social
 * @desc If the interstitial loaded successfully:
 * @member {string} type The value `"ironsource_interstitial_ready"`
 * @event_end
 * 
 * @event social
 * @desc If the interstitial failed to load
 * @member {string} type The value `"ironsource_interstitial_load_failed"`
 * @member {string} error The error message.
 * @event_end
 *
 * @func_end
 */
function ironsource_interstitial_load() {}

/** 
 * @func ironsource_interstitial_is_capped
 * @desc Checks if the interstitial ad for the specified placement is capped.
 * @param {string} placement_name The name of the ad placement.
 * @return {boolean}
 * @func_end
 */
function ironsource_interstitial_is_capped() {}

/** 
 * @func ironsource_interstitial_show
 * @desc Shows the interstitial ad for the specified placement if it is ready.
 * @param {string} placement_name The name of the ad placement.
 * 
 * @event social
 * @desc If the interstitial showed successfully:
 * @member {string} type The value `"ironsource_interstitial_show_succeeded"`
 * @event_end
 * 
 * @event social
 * @desc If the interstitial failed to show:
 * @member {string} type The value `"ironsource_interstitial_show_failed"`
 * @event_end
 * 
 * @event social
 * @desc If the interstitial was clicked:
 * @member {string} type The value `"ironsource_interstitial_clicked"`
 * @event_end
 * 
 * @event social
 * @desc If the interstitial was opened:
 * @member {string} type The value `"ironsource_interstitial_opened"`
 * @event_end
 * 
 * @event social
 * @desc If the interstitial was closed:
 * @member {string} type The value `"ironsource_interstitial_closed"`
 * @event_end
 * 
 * @func_end
 */
function ironsource_interstitial_show() {}

/** 
 * @func ironsource_interstitial_is_ready
 * @desc Checks if the interstitial ad is ready to be shown.
 * @return {boolean}
 * @func_end
 */
function ironsource_interstitial_is_ready() {}

/** 
 * @func ironsource_rewarded_video_init
 * @desc This function initialises the ironSource SDK for the Rewarded Video ad unit.
 *
 * @event social
 * @desc If the rewarded video is ready to be shown:
 * @member {string} type The value `"ironsource_rewarded_video_ready"`
 * @event_end
 * 
 * @event social
 * @desc If the banner loaded successfully:
 * @member {string} type The value `"ironsource_rewarded_video_load_failed"`.
 * @member {string} error The error message.
 * @event_end
 * 
 * @func_end
 */
function ironsource_rewarded_video_init() {}

/** 
 * @func ironsource_rewarded_video_load
 * @desc Loads an rewarded video ad.
 *
 * @event social
 * @desc If the rewarded video ad loaded successfully:
 * @member {string} type The value `"ironsource_rewarded_video_ready"`
 * @event_end
 * 
 * @event social
 * @desc If the rewarded video ad failed to load
 * @member {string} type The value `"ironsource_rewarded_video_load_failed"`
 * @member {string} error The error message.
 * @event_end
 *
 * @func_end
 */
function ironsource_rewarded_video_load() {}

/** 
 * @func ironsource_rewarded_video_show
 * @desc Shows the rewarded video ad for the specified placement if it is available.
 * @param {string} placement_name The name of the ad placement.
 *
 * @event social
 * @desc Triggered when the Rewarded Video ad view has opened. Your game will lose focus.
 * @member {string} type The value `"ironsource_rewarded_video_opened"`.
 * @event_end
 * 
 * @event social
 * @desc Triggered when the Rewarded Video ad view is about to be closed. Your game will regain its focus.
 * @member {string} type The value `"ironsource_rewarded_video_closed"`.
 * @event_end
 * 
 * @event social
 * @desc Triggered when the user finished watching the video and should be rewarded.
 * @member {string} type The value `"ironsource_rewarded_video_rewarded"`.
 * @member {string} reward_name The name of the reward.
 * @member {string} reward_amount The amount the player should be rewarded.
 * @event_end
 * 
 * @event social
 * @desc Triggered when the rewarded video ad failed to show.
 * @member {string} type The value `"ironsource_rewarded_video_show_failed"`.
 * @event_end
 * 
 * @event social
 * @desc Triggered when the video ad was clicked. This callback is not supported by all networks, and we recommend using it only if it's supported by all networks you included in your build.
 * @member {string} type The value `"ironsource_rewarded_video_clicked"`.
 * @event_end
 * @return {real}
 *
 * @func_end
 */
 
 
function ironsource_rewarded_video_show() {}    

/** 
 * @func ironsource_rewarded_video_is_ready
 * @desc Checks if the rewarded video ad is available to be shown.
 * @func_end
 */
function ironsource_rewarded_video_is_ready() {}

/** 
 * @func ironsource_rewarded_video_is_capped
 * @desc Checks if the rewarded video ad for the specified placement is capped.
 * @param {string} placement_name - The name of the ad placement.
 * @return {real}
 * @func_end
 */
function ironsource_rewarded_video_is_capped() {}

/** 
 * @func ironsource_offerwall_init
 * @desc This function initialises the ironSource SDK for the Offerwall ad unit.
 * @event social
 * @desc Triggered when Offerwall initialization starts.
 * @member {string} type The value `"ironsource_offerwall_init"`
 * @event_end
 * 
 * @event social
 * @desc Triggered when there is a change in the Offerwall availability status.
 * @member {string} type The value `"ironsource_offerwall_availability_changed"`
 * @member {boolean} available The value will change to `true` when Offerwall is available.
 * You can then show the offerwall by calling ${function.ironsource_offerwall_show}.
 * @event_end
 * 
 * @version 1.0.2 (-)
 * 
 * @func_end
 */
function ironsource_offerwall_init() {}

/** 
 * @func ironsource_offerwall_get_credits
 * @desc Call this function to check if the Steam API was correctly initialised.
 * 
 * @event social
 * @desc Triggered when the function call succeeds
 * @member {string} type The value `"ironsource_offerwall_credited"`
 * @member {real} credits The number of credits the user has earned.
 * @member {real} total_credits The total number of credits ever earned by the user.
 * @member {boolean} total_credits_flag In some cases, ironSource won’t be able to provide the exact number of credits since the last event. In this case the `credits` will be equal to the `total_credits`, and this flag will be `true`.
 * @event_end
 * 
 * @event social
 * @desc Triggered when the method ${function.ironsource_offerwall_get_credits} fails to retrieve the user's credit balance info.
 * @member {string} type The value `"ironsource_offerwall_credits_failed"`
 * @event_end
 * 
 * @version 1.0.2 (-)
 * 
 * @func_end
 */
function ironsource_offerwall_get_credits() {}

/** 
 * @func ironsource_offerwall_show
 * @desc Shows the Offerwall to the user if it's currently available.
 * 
 * @event social
 * @desc Triggered when the Offerwall successfully loads for the user.
 * @member {string} type The value `"ironsource_offerwall_opened"`
 * @event_end
 * 
 * @event social
 * @desc Triggered when the method ${function.ironsource_offerwall_show} is called and the OfferWall fails to load.
 * @member {string} type The value `"ironsource_offerwall_show_failed"`
 * @member {string} error The error message.
 * @event_end
 * 
 * @event social
 * @desc Triggered when the user is about to return to the application after closing the Offerwall.
 * @member {string} type The value `"ironsource_offerwall_closed"`
 * @event_end
 * 
 * @version 1.0.2 (-)
 * 
 * @func_end
 */
function ironsource_offerwall_show() {}

/** 
 * @func ironsource_offerwall_set_client_side_callbacks
 * @desc Call this function to check if the Steam API was correctly initialised.
 * 
 * @version 1.0.2 (-)
 * 
 * @func_end
 */
function ironsource_offerwall_set_client_side_callbacks() {}

/** 
 * @func ironsource_validate_integration
 * @desc This function validates the ironSource integration. It helps to ensure that the SDK is properly integrated into the app.
 * 
 * @version 1.0.2 (-)
 * 
 * @func_end
 */
function ironsource_validate_integration() {}

// CONSTANTS

/**
 * @const BannerSize
 * @desc These constants represent the size of a given banner.
 * @member Ironsource_BannerSize_Banner Represents the size of a normal banner.
 * @member Ironsource_BannerSize_Large Represents a banner of a large size.
 * @member Ironsource_BannerSize_Rectangle Represents a rectangular banner.
 * @member Ironsource_BannerSize_Smart Represents a dynamically sized banner that adapts to the mobile screen.
 * @const_end
 */

// MODULES

/** 
 * @module general
 * @title General
 * @desc This is a general-purpose module that contains a variety of versatile functions.
 * @section_func
 * @ref ironsource_init
 * @ref ironsource_validate_integration
 * @section_end
 * @module_end
 */

/** 
 * @module banner
 * @title Banner
 * @desc This module contains all functions that handle managing banner ads.
 * @section_func
 * @ref ironsource_banner_*
 * @section_end
 * 
 * @section_const
 * @ref BannerSize
 * @section_end
 * @module_end
 */

/** 
 * @module interstitial
 * @title Interstitial 
 * @desc This module contains all functions that handle managing interstitial ads.
 * @section_func
 * @ref ironsource_interstitial_*
 * @section_end
 * @module_end
 */

/** 
 * @module rewarded
 * @title Rewarded Video
 * @desc This module contains all functions that handle managing rewarded video ads.
 * @section_func
 * @ref ironsource_rewarded_video_*
 * @section_end
 * @module_end
 */

/** 
 * @module offerwall
 * @title Offerwall
 * @desc This module contains all functions that handle managing offerwall ads.
 * @section_func
 * @ref ironsource_offerwall_*
 * @section_end
 * 
 * @version 1.0.2 (-)
 * 
 * @module_end
 */

/** 
 * @module home
 * @title Home
 * @desc This extension allows you to monetise your application by displaying advertisements, interstitials and rewarded video from ironSource.
 * @section Modules
 * @desc There are a great number of different functions related to the ironSource API. We've split them up into the following sections to make it easier to navigate:
 * @ref module.general
 * @ref module.banner
 * @ref module.interstitial
 * @ref module.rewarded
 * @ref module.offerwall
 * @section_end
 * @module_end
 */
