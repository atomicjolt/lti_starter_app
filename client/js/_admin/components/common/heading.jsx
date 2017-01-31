import React                               from 'react';
import { connect }                         from 'react-redux';
import { Wrapper, Button, Menu, MenuItem } from 'react-aria-menubutton';
import assets                              from '../../../libs/assets';

const select = (state, props) => ({
  userName: state.settings.display_name,
  signOutUrl: state.settings.sign_out_url,
});

function handleSelection(value) {
  window.location = value;
}

export class heading extends React.Component {
  static propTypes = {
    back: React.PropTypes.func,
    userName: React.PropTypes.string,
    signOutUrl: React.PropTypes.string.isRequired,
  };

  render() {
    const img = assets('./images/atomicjolt.svg');

    return (
      <header className="c-head">
        <div className="c-back">
          {
            this.props.back ? <button className="c-btn c-btn--back" onClick={this.props.back}>
              <i className="i-back" />
              Back
            </button> : null
          }
        </div>
        <img className="c-logo" src={img} alt="Atomic Jolt Logo" />
        <Wrapper
          className="c-user"
          onSelection={handleSelection}
        >
          <Button className="c-username">
            <span>{this.props.userName}</span>
            <i className="i-dropdown" />
          </Button>
          <Menu className="c-dropdown">
            <ul>
              <li>
                <MenuItem
                  value={this.props.signOutUrl}
                  text="Logout"
                  className="c-menu-item"
                >
                  <a href={this.props.signOutUrl}><span>Logout</span></a>
                </MenuItem>
              </li>
              <li>
                <MenuItem
                  value={`${this.props.signOutUrl}?destroy_authentications=true`}
                  text="Delete"
                  className="c-menu-item"
                >
                  <a href={`${this.props.signOutUrl}?destroy_authentications=true`}>
                    <span>Delete Canvas Authentications and Sign Out</span>
                  </a>
                </MenuItem>
              </li>
            </ul>
          </Menu>
        </Wrapper>
      </header>
    );
  }
}


export default connect(select)(heading);
