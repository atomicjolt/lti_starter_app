
import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { Provider } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { getInitialSettings } from 'atomic-fuel/libs/reducers/settings';
import jwt from 'atomic-fuel/libs/loaders/jwt';
import configureStore from './store/configure_store';
import Index from './components/layout/index';
import initResizeHandler from '../../common/libs/resize_iframe';

import './styles/styles.scss';



class Root extends React.PureComponent {
  static propTypes = {
    store: PropTypes.object.isRequired,
  };

  render() {
    const { store } = this.props;
    return (
      <Provider store={store}>
        <Router>
          <div>
            <Route path="/" exact component={Index} />
          </div>
        </Router>
      </Provider>
    );
  }
}

const settings = getInitialSettings(window.DEFAULT_SETTINGS);
const store = configureStore({ settings, jwt: window.DEFAULT_JWT });
if (window.DEFAULT_JWT) { // Setup JWT refresh
  jwt(store.dispatch, settings.user_id);
}

const mainApp =  document.getElementById('main-app');
initResizeHandler(mainApp);

ReactDOM.render(
  <Root store={store} />,
  mainApp,
);
