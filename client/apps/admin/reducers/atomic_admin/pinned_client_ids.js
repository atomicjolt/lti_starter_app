import _ from 'lodash';
import { Constants as ClientIdConstants } from '../../actions/atomic_admin/pinned_client_ids';

const initialState = {
  pinnedClientIds: [],
  totalPages: 0,
  loading: true,
  loaded: false,
};

export default function instances(state = initialState, action) {
  switch (action.type) {
    case ClientIdConstants.GET_PINNED_CLIENT_IDS_DONE: {
      const newState = _.cloneDeep(initialState);
      const {
        pinned_client_ids,
        page,
        total_pages: totalPages,
      } = action.payload;


      newState.totalPages = totalPages;
      newState.loading = false;
      newState.loaded = true
      newState.pinnedClientIds = pinned_client_ids;
      return newState;
    }

    case ClientIdConstants.DELETE_PINNED_CLIENT_ID_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.pinnedClientIds, (p) => (
        p.id === action.original.pinnedClientIdId
      ));
      newState.loading = false;
      return newState;
    }


    case ClientIdConstants.UPDATE_PINNED_CLIENT_ID_DONE: {
      const newState = _.cloneDeep(state);
      const i = _.findIndex(newState.pinnedClientIds, (p) => (
        p.id === action.original.pinnedClientIdId
      ));

      if(i > -1 && action.payload.pinned_client_id && !_.isEmpty(action.payload.pinned_client_id)){
        newState.pinnedClientIds[i] = action.payload.pinned_client_id
      }
      
      newState.loading = false;
      return newState;
    }

    case ClientIdConstants.CREATE_PINNED_CLIENT_ID_DONE: {

      const newState = _.cloneDeep(state);
      
      if(action.payload.pinned_client_id && !_.isEmpty(action.payload.pinned_client_id)){

        newState.pinnedClientIds.push(action.payload.pinned_client_id)
      }
      newState.loading = false;
      return newState;
    }

    case ClientIdConstants.GET_PINNED_CLIENT_ID:
    case ClientIdConstants.SAVE_PINNED_CLIENT_ID:
    case ClientIdConstants.DELETE_PINNED_CLIENT_ID:
    case ClientIdConstants.GET_PINNED_CLIENT_IDS:
    case ClientIdConstants.CREATE_PINNED_CLIENT_ID: {
      const newState = _.cloneDeep(state);
      newState.loading = true;
      return newState;
    }
    
    default:
      return state;
  }
}
