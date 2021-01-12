import React from 'react';
import PropTypes from 'prop-types';
import gql from 'graphql-tag';
import { Redirect } from 'react-router-dom';
import { useQuery } from '@apollo/react-hooks';
import { withSettings } from 'atomic-fuel/libs/components/settings';

import DeepLink from './deep_link';

import assets from '../libs/assets';

export const GET_WELCOME = gql`
  query getWelcome($name: String!) {
    welcomeMessage(name: $name)
  }
`;

const Home = ({ settings }) => {
  const { loading, error, data } = useQuery(GET_WELCOME, {
    variables: {
      name: 'World',
    },
  });

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  if (!settings.lti_launch_is_configured) {
    return <Redirect to="/setup" />;
  }

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
      <h1>
        { settings.lti_launch_config.title }
      </h1>
      <img src={img} alt="Atomic Jolt Logo" />
      <p>
        {data.welcomeMessage}
      </p>
      <p>
        by
        <a href="http://www.atomicjolt.com">Atomic Jolt</a>
      </p>
    </div>
  );

};

Home.propTypes = {
  settings: PropTypes.shape({
    deep_link_settings: PropTypes.object,
  }).isRequired,
};

export default withSettings(Home);
