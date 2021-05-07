import 'core-js';
import 'regenerator-runtime/runtime';
import es6Promise from 'es6-promise';
import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { Provider } from 'react-redux';
import _ from 'lodash';
import { ApolloProvider } from '@apollo/react-hooks';
import { ApolloClient } from 'apollo-client';
import { HttpLink } from 'apollo-link-http';
import { ApolloLink } from 'apollo-link';
import { withClientState } from 'apollo-link-state';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { Router } from 'react-router';
import { Route } from 'react-router-dom';
import { Jwt } from 'atomic-fuel/libs/loaders/jwt';
import settings from './settings';
import configureStore from './store/configure_store';

import appHistory from './history';
import Index from './components/layout/index';
import initResizeHandler from '../../common/libs/resize_iframe';

import './styles/styles';

// Polyfill es6 promises for IE
es6Promise.polyfill();

const jwt = new Jwt(window.DEFAULT_JWT, window.DEFAULT_SETTINGS.api_url);
jwt.enableRefresh();

function Root(props) {
  const { client, store } = props;
  return (
    <Provider store={store}>
      <ApolloProvider client={client}>
        <Router history={appHistory}>
          <Route path="/" component={Index} />
        </Router>
      </ApolloProvider>
    </Provider>
  );
}

Root.propTypes = {
  client: PropTypes.object.isRequired,
  store: PropTypes.object.isRequired,
};

const inCacheMemory = new InMemoryCache();

const stateLink = withClientState({
  cache: inCacheMemory,
  resolvers: {
    Mutation: {},
  },
  defaults: {},
});

const links = [
  stateLink
];

if (!_.isEmpty(settings.api_url)) {
  const authenticationLink = new ApolloLink((operation, forward) => {
    operation.setContext({
      headers: {
        authorization: `Bearer ${jwt.currentJwt}`
      }
    });
    return forward(operation);
  });
  links.push(authenticationLink);

  const httpLink = new HttpLink({
    uri: `${settings.api_url}api/graphql`,
  });
  links.push(httpLink);
}

const client = new ApolloClient({
  link: ApolloLink.from(links),
  cache: inCacheMemory,
});

const mainApp =  document.getElementById('main-app');
initResizeHandler(mainApp);

const store = configureStore({ jwt: window.DEFAULT_JWT });

ReactDOM.render(
  <Root client={client} store={store} />,
  mainApp,
);
