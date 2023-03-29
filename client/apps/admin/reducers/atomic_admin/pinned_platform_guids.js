import _ from 'lodash';
import { Constants as PlatformConstants } from '../../actions/atomic_admin/pinned_platform_guids';

const initialState = {
  pinnedPlatformGuids: [],
  totalPages: 0,
  loading: true,
  loaded: false,
};

export default function instances(state = initialState, action) {
  switch (action.type) {
    case PlatformConstants.GET_PINNED_PLATFORM_GUIDS_DONE: {
      const newState = _.cloneDeep(initialState);
      const {
        pinned_platform_guids,
        page,
        total_pages: totalPages,
      } = action.payload;


      newState.totalPages = totalPages;
      newState.loading = false;
      newState.loaded = true
      newState.pinnedPlatformGuids = pinned_platform_guids;
      return newState;
    }

    case PlatformConstants.DELETE_PINNED_PLATFORM_GUID_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.pinnedPlatformGuids, (p) => (
        p.id === action.original.pinnedPlatformGuidId
      ));
      newState.loading = false;
      return newState;
    }


    case PlatformConstants.UPDATE_PINNED_PLATFORM_GUID_DONE: {
      const newState = _.cloneDeep(state);
      const i = _.findIndex(newState.pinnedPlatformGuids, (p) => (
        p.id === action.original.pinnedPlatformGuidId
      ));

      if(i > -1 && action.payload.pinned_platform_guid && !_.isEmpty(action.payload.pinned_platform_guid)){
        newState.pinnedPlatformGuids[i] = action.payload.pinned_platform_guid
      }
      
      newState.loading = false;
      return newState;
    }

    case PlatformConstants.CREATE_PINNED_PLATFORM_GUID_DONE: {

      const newState = _.cloneDeep(state);
      
      if(action.payload.pinned_platform_guid && !_.isEmpty(action.payload.pinned_platform_guid)){

        newState.pinnedPlatformGuids.push(action.payload.pinned_platform_guid)
      }
      newState.loading = false;
      return newState;
    }

    case PlatformConstants.GET_PINNED_PLATFORM_GUID:
    case PlatformConstants.SAVE_PINNED_PLATFORM_GUID:
    case PlatformConstants.DELETE_PINNED_PLATFORM_GUID:
    case PlatformConstants.GET_PINNED_PLATFORM_GUIDS:
    case PlatformConstants.CREATE_PINNED_PLATFORM_GUID: {
      const newState = _.cloneDeep(state);
      newState.loading = true;
      return newState;
    }
    
    default:
      return state;
  }
}
