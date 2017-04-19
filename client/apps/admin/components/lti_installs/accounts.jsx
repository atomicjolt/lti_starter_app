import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import SubAccount from './sub_account';

export default class Accounts extends React.Component {

  accounts() {
    return _(this.props.accounts)
      .filter({ parent_account_id: null })
      .sortBy('name')
      .map(account => (
        <SubAccount
          key={`account_${account.id}`}
          account={account}
          setAccountActive={this.props.setAccountActive}
          accounts={this.props.accounts}
          currentAccount={this.props.currentAccount}
          isActive={this.props.currentAccount && account.id === this.props.currentAccount.id}
        />
      ))
      .value();
  }

  render() {
    return (
      <ul className="c-filter-list">
        {this.accounts()}
      </ul>
    );
  }
}

Accounts.propTypes = {
  accounts         : PropTypes.shape({}).isRequired,
  setAccountActive : PropTypes.func.isRequired,
  currentAccount   : PropTypes.shape({
    id: PropTypes.number
  }),
};
