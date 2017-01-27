import React               from 'react';
import _                   from 'lodash';
import { getSubAccountsOfAccount } from '../../../libs/canvas/constants/accounts';

export default class SubAccounts extends React.Component {

  getSubAccounts(account) {
    this.props.canvasRequest(getSubAccountsOfAccount, { account_id: account.id }, {}, account);
  }

  accounts(accounts) {
    return _.map(accounts, account => (
      <li className="c-filter__item">
        <a onClick={() => this.getSubAccounts(account)}>
          <span>
            <i className="i-dropdown" />
            {account.name}
          </span>
        </a>
        {
          account.subAccounts ? <ul className="c-filter__dropdown">
            {this.accounts(account.subAccounts)}
          </ul> : null
        }
      </li>
    ));
  }

  render() {

    return (
      <ul className="c-filter__dropdown">
        {this.accounts(this.props.accounts)}
      </ul>
    );
  }
}

SubAccounts.propTypes = {
  accounts: React.PropTypes.arrayOf(React.PropTypes.shape({

  })).isRequired
};
