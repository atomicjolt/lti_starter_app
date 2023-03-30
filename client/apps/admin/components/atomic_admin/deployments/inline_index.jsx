import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Loader from '../../../../../common/components/common/atomicjolt_loader';
import * as PlatformActions from '../../../actions/atomic_admin/lti_platforms';
import * as ApplicationInstanceActions from '../../../actions/application_instances';
import * as DeploymentActions from '../../../actions/atomic_admin/deployments';
import List from '../list';
import Header from './header';

const select = (state) => ({
  platforms: state.platforms,
  deployments: state.deployments?.deployments,
  loading: state.deployments?.loading,
  applications: state.applications,
  applicationInstances: state.applicationInstances,
  sites: state.sites,
});

export function Index(props) {

  const {
    platforms,
    loading,
    params,
    deployments,
  } = props;

  useEffect(() => { props.getPlatforms(); }, []);
  useEffect(() => { props.getDeployments(params.applicationInstanceId); }, []);

  const issOptions = _.map(platforms?.platforms, (p) => ({ label: p.iss, value: p.iss }));

  const fields = () => [
    {
      label: 'Iss', prop: 'iss', field: 'iss', options: issOptions, showInSummary: false
    },
    {
      label: 'Client ID', prop: 'client_id', field: 'client_id', showInSummary: false
    },
    {
      label: 'Platform Instance Guid', prop: 'platform_guid', field: 'platform_guid', showInSummary: false
    },
    {
      label: 'Deployment Id', prop: 'deployment_id', field: 'deployment_id', showInSummary: true
    },
  ];

  const renderLoading = () => (
    <div className="aj-loading-space-top">
      <Loader />
    </div>
  );

  return (
    <div>

      {loading ? renderLoading() : (
        <div className="__aj-admin-container">
          <Header
            fields={fields()}
            saveElement={(data) => {
              props.createDeployment(data);
            }}
            staticElementFields={{
              application_instance_id: parseInt(params.applicationInstanceId, 10),
              application_id: parseInt(params.applicationId, 10),
            }}
          />
          <List
            fields={fields()}
            elements={deployments}
            saveElement={(id, data) => {
              props.updateDeployment(id, data);
            }}
            deleteElement={props.deleteDeployment}
            emptyText="No deployments exist yet."
          />
        </div>
      )}
    </div>
  );
}

export default connect(
  select, { ...PlatformActions, ...DeploymentActions, ...ApplicationInstanceActions }
)(Index);
// export default Index

// Index.propTypes = {
//   params: PropTypes.shape({
//     applicationId: PropTypes.string.isRequired,
//     applicationInstanceId: PropTypes.string.isRequired,
//   }).isRequired,
//   applications: PropTypes.shape({}).isRequired,
//   getApplicationInstance: PropTypes.func,
//   applicationInstances: PropTypes.array,
//   router: PropTypes.shape({
//     push: PropTypes.func,
//   }),
//   loading: PropTypes.bool,
//   sites: PropTypes.shape({}).isRequired,
//   deleteApplicationInstance: PropTypes.func,
//   disableApplicationInstance: PropTypes.func,
//   children: PropTypes.element,
//   location: PropTypes.shape({}),
// };
