import React from 'react';
import PropTypes from 'prop-types';
import gql from 'graphql-tag';
import { useQuery } from '@apollo/react-hooks';
import { withSettings } from 'atomic-fuel/libs/components/settings';
import { useSelector } from 'react-redux';

import DeepLink from './deep_link';

import assets from '../libs/assets';
import { displayCanvasAuth } from '../../../common/components/common/canvas_auth';

export const GET_WELCOME = gql`
  query getWelcome($name: String!) {
    welcomeMessage(name: $name)
  }
`;

const Home = ({ settings }) => {
  const canvasReAuthorizationRequired = useSelector((state) => state.canvasErrors.canvasReAuthorizationRequired);

  const { loading, error, data } = useQuery(GET_WELCOME, {
    variables: {
      name: 'World',
    },
  });

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  const img = assets('./images/atomicjolt.jpg');

  if (settings.deep_link_settings) {
    return (
      <DeepLink
        deepLinkSettings={settings.deep_link_settings}
      />
    );
  }

  return (
    <div>
      <img src={img} alt="Atomic Jolt Logo" />
      <p>
        {data.welcomeMessage}
      </p>
      <p>
        by
        <a href="http://www.atomicjolt.com">Atomic Jolt</a>
      </p>
      { displayCanvasAuth(settings, canvasReAuthorizationRequired) }
    </div>
  );

};

Home.propTypes = {
  settings: PropTypes.shape({
    deep_link_settings: PropTypes.object,
  }).isRequired,
};

export default withSettings(Home);
