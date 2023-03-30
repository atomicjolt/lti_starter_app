import React from 'react';
import { Provider } from 'react-redux';
import PropTypes from 'prop-types';
import routes from './routes';

export default class Root extends React.PureComponent {
  static propTypes = {
    store: PropTypes.object.isRequired,
  };

  componentDidMount() {
    window.addEventListener('click', this.closeMenus);
  }

  componentWillUnmount() {
    window.removeEventListener('click', this.closeMenus);
  }

  closeMenus = () => {
    window.dispatchEvent(new CustomEvent('close-menu'));
  }

  render() {
    const { store } = this.props;
    return (
      <Provider store={store}>
        <div>
          {routes}
        </div>
      </Provider>
    );
  }
}
