//
// Webhooks Subscriptions
//
// Create a Webhook Subscription
// Creates a webook subscription for the specified event type and
// context.
//
// API Docs: https://canvas.instructure.com/doc/api/webhooks_subscriptions.html
// API Url: /lti/subscriptions
//
// Example:
// const query = {
//   submission[ContextId] (required)
//   subscription[ContextType] (required)
//   subscription[EventTypes] (required)
//   subscription[Format] (required)
//   subscription[TransportMetadata] (required)
//   subscription[TransportType] (required)
// }
// return canvasRequest(create_webhook_subscription, {}, query);
export const createWebhookSubscription = { type: 'CREATE_WEBHOOK_SUBSCRIPTION', method: 'post', key: 'create_webhook_subscription', required: [] };

// Delete a Webhook Subscription
// 
//
// API Docs: https://canvas.instructure.com/doc/api/webhooks_subscriptions.html
// API Url: /lti/subscriptions/{id}
//
// Example:
// return canvasRequest(delete_webhook_subscription, {id});
export const deleteWebhookSubscription = { type: 'DELETE_WEBHOOK_SUBSCRIPTION', method: 'delete', key: 'delete_webhook_subscriptiondelete_webhook_subscription_id', required: ['id'] };

// Show a single Webhook Subscription
// 
//
// API Docs: https://canvas.instructure.com/doc/api/webhooks_subscriptions.html
// API Url: /lti/subscriptions/{id}
//
// Example:
// return canvasRequest(show_single_webhook_subscription, {id});
export const showSingleWebhookSubscription = { type: 'SHOW_SINGLE_WEBHOOK_SUBSCRIPTION', method: 'get', key: 'show_single_webhook_subscriptionshow_single_webhook_subscription_id', required: ['id'] };

// Update a Webhook Subscription
// This endpoint uses the same parameters as the create endpoint
//
// API Docs: https://canvas.instructure.com/doc/api/webhooks_subscriptions.html
// API Url: /lti/subscriptions/{id}
//
// Example:
// return canvasRequest(update_webhook_subscription, {id});
export const updateWebhookSubscription = { type: 'UPDATE_WEBHOOK_SUBSCRIPTION', method: 'put', key: 'update_webhook_subscriptionupdate_webhook_subscription_id', required: ['id'] };

// List all Webhook Subscription for a tool proxy
// This endpoint returns a paginated list with a default limit of 100 items per result set.
// You can retrieve the next result set by setting a 'StartKey' header in your next request
// with the value of the 'EndKey' header in the response.
// 
// Example use of a 'StartKey' header object:
//   { "Id":"71d6dfba-0547-477d-b41d-db8cb528c6d1","DeveloperKey":"10000000000001" }
//
// API Docs: https://canvas.instructure.com/doc/api/webhooks_subscriptions.html
// API Url: /lti/subscriptions
//
// Example:
// return canvasRequest(list_all_webhook_subscription_for_tool_proxy, {});
export const listAllWebhookSubscriptionForToolProxy = { type: 'LIST_ALL_WEBHOOK_SUBSCRIPTION_FOR_TOOL_PROXY', method: 'get', key: 'list_all_webhook_subscription_for_tool_proxy', required: [] };