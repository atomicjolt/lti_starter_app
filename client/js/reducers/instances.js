const initialState = {};

export default function instances(state = initialState, action) {
  switch (action.type) {

    case 'GET_INSTANCES_DONE':
      debugger;
      return state;

    default:
      return state;
  }
}
