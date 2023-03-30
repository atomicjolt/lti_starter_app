import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Heading from '../../common/heading';
import Loader from '../../../../../common/components/common/atomicjolt_loader';
import * as PlatformActions from '../../../actions/atomic_admin/lti_platforms';
import List from './list'
import Header from './header'

const select = (state, props) => {
  return {
    platforms: state.platforms.platforms,
    loading: state.platforms.loading, 
    applications: state.applications,
    sites: state.sites,
  }};

const FIELDS = [
  {label: 'Iss' , prop: 'iss', field: 'iss'},
  {label: 'Jwks Url', prop: 'jwks_url', field: 'jwks_url'},
  {label: 'Token Url', prop: 'token_url', field: 'token_url'},
  {label: 'OIDC Url', prop: 'oidc_url', field: 'oidc_url'}
];

export function Index(props) {

  const {
    loading,
    params,
    applications,
    platforms
  } = props;

  useEffect(() => { props.getPlatforms(); }, []);

  const application = applications[params.applicationId];
  // const applicationInstance = _.filter(applicationInstances, (app) => (
  //   app.id === _.parseInt(params.applicationInstanceId)
  // ))[0];
  let backPath = '';
  if (!loading) {
    backPath = `/applications/`;
  }

  const renderLoading = () => (
    <div className="aj-loading-space-top">
      <Loader />
    </div>
  );

  return (
    <div>
      <Heading
        backTo="/applications"
        application={application}
      />
      {loading ? renderLoading() : (
        <div className="aj-admin-container">
          <Header fields={FIELDS} createPlatform={props.createPlatform}/>
          <List 
            fields={FIELDS}
            elements={platforms}
            saveElement={(id, data) => {props.updatePlatform(id, data)}}
            createElement={props.createPlatform}
            deleteElement={props.deletePlatform}
            emptyText={"No Platforms are currently configured."}
          />
        </div>
      )}
    </div>
  );
}


export default connect(select, PlatformActions)(Index);
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
