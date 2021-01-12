import React from 'react';
import PropTypes from 'prop-types';
import gql from 'graphql-tag';
import { Redirect } from 'react-router-dom';
import { useQuery, useMutation } from '@apollo/react-hooks';
import { withSettings } from 'atomic-fuel/libs/components/settings';

import assets from '../libs/assets';

export const COPY_LTI_LAUNCH = gql`
  mutation copyLtiLaunch($id: ID!, $sourceId: ID!, $secureToken: String!) {
    copyLtiLaunch(id: $id, sourceId: $sourceId, secureToken: $secureToken) {
      ltiLaunch {
        id
        config
        isConfigured
      }
    }
  }
`;


const Setup = ({ settings }) => {

  const [copyLtiLaunch, { data, loading, error }] = useMutation(COPY_LTI_LAUNCH);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  if (data) {
    return <h2>Please reload this window to launch the tool</h2>;
  }

  const selectItem = (ltiLaunch) => {
    const variables = {
      id: settings.lti_launch_id,
      sourceId: ltiLaunch.id,
      secureToken: ltiLaunch.context.secure_token,
    };
    copyLtiLaunch({ variables });
  };
  const launchItems = settings.lti_matching_launches.map((ltiLaunch) => (
    <li key={ltiLaunch.id}>
      <div>
        {`Title: ${ltiLaunch.config.title}`}
      </div>
      <div>
        {`Course: ${ltiLaunch.context.title} / ${ltiLaunch.context.platform_instance.name}`}
      </div>
      <div>
        {`Date created: ${ltiLaunch.created_at}`}
      </div>
      <button type="submit" onClick={() => selectItem(ltiLaunch)}>Select</button>
    </li>
  ));

  if (launchItems.length === 0) {
    return <h2>No matching item found.</h2>;
  }

  return (
    <div className="lti-selection-list">
      <h2>This item has been copied</h2>
      <p>
        Please select an existing instance:
      </p>
      <ul>
        { launchItems }
      </ul>
    </div>
  );

};

Setup.propTypes = {
  settings: PropTypes.shape({
    lti_launch_is_configured: PropTypes.bool,
    lti_launch_config: PropTypes.object,
    lti_matching_launches: PropTypes.array,
  }).isRequired,
};

export default withSettings(Setup);
