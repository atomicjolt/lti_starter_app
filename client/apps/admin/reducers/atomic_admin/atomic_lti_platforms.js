import _ from 'lodash';
import { Constants as PlatformConstants } from '../../actions/atomic_admin/lti_platforms';

const initialState = {
  platforms: [],
  totalPages: 0,
  loading: true,
  loaded: false,
};

export default function instances(state = initialState, action) {
  switch (action.type) {
    case PlatformConstants.GET_PLATFORMS_DONE: {
      const newState = _.cloneDeep(initialState);
      const {
        platforms,
        page,
        total_pages: totalPages,
      } = action.payload;

      newState.totalPages = totalPages;
      newState.loading = false;
      newState.loaded = true
      newState.platforms = platforms;
      return newState;
    }

    case PlatformConstants.DELETE_PLATFORM_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.platforms, (p) => (
        p.id === action.original.platformId
      ));
      newState.loading = false;
      return newState;
    }


    case PlatformConstants.UPDATE_PLATFORM_DONE: {
      const newState = _.cloneDeep(state);
      const i = _.findIndex(newState.platforms, (p) => (
        p.id === action.original.platformId
      ));

      if(i > -1 && action.payload.platform && !_.isEmpty(action.payload.platform)){
        newState.platforms[i] = action.payload.platform
      }
      
      newState.loading = false;
      return newState;
    }

    case PlatformConstants.CREATE_PLATFORM_DONE: {

      const newState = _.cloneDeep(state);
      
      if(action.payload.platform && !_.isEmpty(action.payload.platform)){

        newState.platforms.push(action.payload.platform)
      }
      newState.loading = false;
      return newState;
    }

    case PlatformConstants.GET_PLATFORM:
    case PlatformConstants.SAVE_PLATFORM:
    case PlatformConstants.DELETE_PLATFORM:
    case PlatformConstants.GET_PLATFORMS:
    case PlatformConstants.CREATE_PLATFORM: {
      const newState = _.cloneDeep(state);
      newState.loading = true;
      return newState;
    }

    // case ApplicationInstancesConstants.DISABLE_APPLICATION_INSTANCE_DONE:
    // case ApplicationInstancesConstants.GET_APPLICATION_INSTANCE_DONE:
    // case ApplicationInstancesConstants.SAVE_APPLICATION_INSTANCE_DONE:
    // case ApplicationInstancesConstants.CREATE_APPLICATION_INSTANCE_DONE: {
    //   const newState = _.cloneDeep(state);
    //   const instanceClone = _.cloneDeep(action.payload);
    //   instanceClone.config = JSON.stringify(action.payload.config);
    //   instanceClone.lti_config = JSON.stringify(action.payload.lti_config);
    //   _.remove(newState.applicationInstances, (ai) => (
    //     ai.id === action.payload.id
    //   ));
    //   newState.applicationInstances.push(instanceClone);
    //   newState.loading = false;
    //   newState.loaded = true;
    //   return newState;
    // }

    // case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE_DONE: {
    //   const newState = _.cloneDeep(state);
    //   _.remove(newState.applicationInstances, (ai) => (
    //     ai.id === action.original.applicationInstanceId
    //   ));
    //   newState.loading = false;
    //   return newState;
    // }

    // case ApplicationInstancesConstants.UPDATE_NEW_INSTANCE: {
    //   const newState = _.cloneDeep(state);
    //   newState.newApplicationInstance = action.newApplicationInstance;
    //   return newState;
    // }

    // case ApplicationInstancesConstants.DISABLE_APPLICATION_INSTANCE:
    // case ApplicationInstancesConstants.GET_APPLICATION_INSTANCE:
    // case ApplicationInstancesConstants.SAVE_APPLICATION_INSTANCE:
    // case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE:
    // case ApplicationInstancesConstants.GET_APPLICATION_INSTANCES:
    // case ApplicationInstancesConstants.CREATE_APPLICATION_INSTANCE: {
    //   const newState = _.cloneDeep(state);
    //   newState.loading = true;
    //   return newState;
    // }

    // case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE_AUTH_DONE: {
    //   const newState = _.cloneDeep(state);
    //   const applicationInstance = _.find(newState.applicationInstances, ai => (
    //     ai.id === action.original.applicationInstanceId
    //   ));
    //   _.remove(applicationInstance.authentications, au => (
    //     au.id === action.original.authenticationId
    //   ));
    //   return newState;
    // }

    default:
      return state;
  }
}
