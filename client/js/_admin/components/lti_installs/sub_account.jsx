import React from 'react';
import _     from 'lodash';

export default class SubAccount extends React.Component {
  static propTypes = {
    accounts: React.PropTypes.shape({}),
    account: React.PropTypes.shape({
      id: React.PropTypes.number,
      name: React.PropTypes.string,
    }).isRequired,
    isActive: React.PropTypes.bool,
    currentAccount: React.PropTypes.shape({
      id: React.PropTypes.number,
    }),
    setAccountActive: React.PropTypes.func.isRequired
  }
  constructor() {
    super();
    this.state = {
      open: false,
    };
  }

  getChildrenAccounts() {
    return _(this.props.accounts)
      .filter({ parent_account_id: this.props.account.id })
      .sortBy('name')
      .map(child => (
        <SubAccount
          key={`account_${child.id}`}
          account={child}
          setAccountActive={this.props.setAccountActive}
          accounts={this.props.accounts}
          currentAccount={this.props.currentAccount}
          isActive={this.props.currentAccount && child.id === this.props.currentAccount.id}
        />
      ))
      .value();
  }

  handleAccountClick() {
    this.setState({ open: !this.state.open });
    this.props.setAccountActive(this.props.account);
  }

  render() {
    const childrenAccounts = this.getChildrenAccounts();
    return (
      <li
        key={`account_${this.props.account.id}`}
        className={this.props.isActive ? 'c-filter__item is-active' : 'c-filter__item'}
      >
        <button onClick={() => this.handleAccountClick()}>
          { childrenAccounts.length ? <i className={this.state.open ? 'i-dropdown is-open' : 'i-dropdown'} /> : null }
          {this.props.account.name}
        </button>
        {
          this.state.open ? <ul className="c-filter__dropdown">{childrenAccounts}</ul> : null
        }
      </li>
    );
  }
}
