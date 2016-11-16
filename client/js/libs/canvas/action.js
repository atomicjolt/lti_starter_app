//
// parameters:
//   canvas    - The object related to the Canvas api call to be made. ie search_account_domains
//   params    - The params passed to Canvas
//   body      - The body of the request. Used for POST and PUT
//   localData - An object containing data that the action will hold onto for local usage but will not be passed to the server.
export default function(canvas, params, body, localData = {}){
  return {
    type: canvas.type,
    canvas,
    params,
    body,
    localData
  };
}