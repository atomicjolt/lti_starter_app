import _ from 'lodash';
import { Constants as DeploymentConstants } from '../../actions/atomic_admin/deployments';

const initialState = {
  deployments: [],
  totalPages: 0,
  loading: true,
  loaded: false,
};

export default function instances(state = initialState, action) {
  switch (action.type) {
    case DeploymentConstants.GET_DEPLOYMENTS_DONE: {
      const newState = _.cloneDeep(initialState);
      const {
        deployments,
        page,
        total_pages: totalPages,
      } = action.payload;


      newState.totalPages = totalPages;
      newState.loading = false;
      newState.loaded = true
      newState.deployments = deployments;
      return newState;
    }

    case DeploymentConstants.DELETE_DEPLOYMENT_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.deployments, (p) => (
        p.id === action.original.deploymentId
      ));
      newState.loading = false;
      return newState;
    }


    case DeploymentConstants.UPDATE_DEPLOYMENT_DONE: {
      const newState = _.cloneDeep(state);
      const i = _.findIndex(newState.deployments, (p) => (
        p.id === action.original.deploymentId
      ));

      if(i > -1 && action.payload.deployment && !_.isEmpty(action.payload.deployment)){
        newState.deployments[i] = action.payload.deployment
      }
      
      newState.loading = false;
      return newState;
    }

    case DeploymentConstants.CREATE_DEPLOYMENT_DONE: {

      const newState = _.cloneDeep(state);
      
      if(action.payload.deployment && !_.isEmpty(action.payload.deployment)){

        newState.deployments.push(action.payload.deployment)
      }
      newState.loading = false;
      return newState;
    }

    case DeploymentConstants.GET_DEPLOYMENT:
    case DeploymentConstants.SAVE_DEPLOYMENT:
    case DeploymentConstants.DELETE_DEPLOYMENT:
    case DeploymentConstants.GET_DEPLOYMENTS:
    case DeploymentConstants.CREATE_DEPLOYMENT: {
      const newState = _.cloneDeep(state);
      newState.loading = true;
      return newState;
    }
    
    default:
      return state;
  }
}
