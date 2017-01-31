import React               from 'react';
import _                   from 'lodash';
import { getSubAccountsOfAccount } from '../../../libs/canvas/constants/accounts';

export default class SubAccounts extends React.Component {

  getSubAccounts(account) {
    const { activeAccount } = this.props;
    this.props.canvasRequest(getSubAccountsOfAccount, { account_id: account.id }, {}, account);
    this.props.setAccount(activeAccount && activeAccount.id === account.id ? null : account);
  }

  shouldShowAccounts(account) {
    const { activeAccount } = this.props;
    return account.subAccounts && activeAccount
      && (activeAccount.id === account.id || activeAccount.parent_account_id === account.id);
  }

  accounts(accounts) {
    const { activeAccount } = this.props;

    return _.map(accounts, account => (
      <li
        key={`account_${account.id}`}
        className={activeAccount && activeAccount.id === account.id ? 'c-filter__item is-active' : 'c-filter__item'}
      >
        <span>
          <i className="i-dropdown" />
          {account.name}
        </span>
        {
          this.shouldShowAccounts(account) ? <ul className="c-filter__dropdown">
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
  accounts: React.PropTypes.shape({}),
  canvasRequest: React.PropTypes.func.isRequired,
  setAccount: React.PropTypes.func.isRequired,
  activeAccount: React.PropTypes.shape({}),
};
