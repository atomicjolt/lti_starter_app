import 'core-js';
import 'regenerator-runtime/runtime';
import es6Promise from 'es6-promise';
import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { Provider } from 'react-redux';
import _ from 'lodash';
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  HttpLink,
  ApolloLink,
} from '@apollo/client';
import { Router } from 'react-router';
import { Route } from 'react-router-dom';
import { Jwt } from 'atomic-fuel/libs/loaders/jwt';
import { ltiLaunch } from '@atomicjolt/lti-client/src/client/launch';

import settings from './settings';
import configureStore from './store/configure_store';
import appHistory from './history';
import Index from './components/layout/index';
import initResizeHandler from '../../common/libs/resize_iframe';

import './styles/styles.scss';

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

const links = [];

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
  cache: new InMemoryCache(),
  resolvers: {
    Mutation: {},
  },
});

const mainApp =  document.getElementById('main-app');
initResizeHandler(mainApp);

const store = configureStore({ jwt: window.DEFAULT_JWT });

ltiLaunch(window.DEFAULT_SETTINGS).then((valid) => {
  if (valid) {
    ReactDOM.render(
      <Root store={store} client={client} />,
      mainApp,
    );
  } else {
    document.body.innerHTML = 'Invalid request. Please reload the page.';
  }
});
