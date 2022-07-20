import React from 'react';
import PropTypes from 'prop-types';
import gql from 'graphql-tag';
import { useQuery } from '@apollo/client';
import { withSettings } from 'atomic-fuel/libs/components/settings';
import { useSelector } from 'react-redux';

import DeepLink from './deep_link';

import { displayCanvasAuth } from '../../../common/components/common/canvas_auth';
import img  from '../assets/images/atomicjolt.jpg';

export const GET_WELCOME = gql`
  query getWelcome($name: String!) {
    welcomeMessage(name: $name)
  }
`;

function Home({ settings }) {
  const authRequired = useSelector((state) => state.canvasErrors.canvasReAuthorizationRequired);
  const { loading, error, data } = useQuery(GET_WELCOME, {
    variables: {
      name: 'World',
    },
  });

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

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
      { displayCanvasAuth(settings, authRequired) }
    </div>
  );

}

Home.propTypes = {
  settings: PropTypes.shape({
    deep_link_settings: PropTypes.object,
  }).isRequired,
};

export default withSettings(Home);
