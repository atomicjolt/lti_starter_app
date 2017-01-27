import React               from 'react';
import _                   from 'lodash';

export default class SubAccounts extends React.Component {

  accounts() {
    const accounts = _.map(this.props.accounts, account => (
      <li className="c-filter__item">
        <a href="">
          <span>
            <i className="i-dropdown" />
            {account.name}
          </span>
        </a>
      </li>
    ));
    return accounts;
  }

  render() {

    return (
      <ul className="c-filter__dropdown">
        {this.accounts()}
      </ul>
    );
  }
}

SubAccounts.propTypes = {
  accounts: React.PropTypes.arrayOf(React.PropTypes.shape({

  })).isRequired
};
