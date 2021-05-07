import React from 'react';
import PropTypes from 'prop-types';
import { Trans } from 'react-i18next';
import { Link } from 'react-router3';

export default class TopBar extends React.Component {

  static propTypes = {
    goBack: PropTypes.func,
    title: PropTypes.string,
    path: PropTypes.string,
    pathTitle: PropTypes.string,
  };

  render() {
    const { goBack, title, path, pathTitle } = this.props;
    return (
      <div className="aj-header aj-header__analytics">
        <div className="aj-flex">
          <button
            onClick={() => goBack()}
            className="aj-icon-btn"
            type="button"
          >
            <i className="material-icons">arrow_back</i>
          </button>
          <div className="aj-subtitle">
            <Trans>{title}</Trans>
          </div>
        </div>
        <div className="aj-link">
          {path && <Link to={path}><Trans>{pathTitle}</Trans></Link>}
        </div>
      </div>
    );
  }
}

