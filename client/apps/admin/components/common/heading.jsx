import React                               from 'react';
import { connect }                         from 'react-redux';
import { Wrapper, Button, Menu, MenuItem } from 'react-aria-menubutton';
import { Link }                            from 'react-router';
import assets                              from '../../libs/assets';
import SubNav                              from '../common/sub_nav';

const select = state => ({
  userName: state.settings.display_name,
  signOutUrl: state.settings.sign_out_url,
});

function handleSelection(value) {
  window.location = value;
}

export function Heading(props) {
  const img = assets('./images/atomicjolt.svg');

  let back = null;
  if (props.backTo) {
    back = (
      <button className="c-btn c-btn--back">
        <Link to={props.backTo}>
          <i className="i-back" />
          Back
        </Link>
      </button>
    );
  }

  return (
    <div>
      <header className="c-head">
        <div className="c-back">
          {back}
        </div>
        <img className="c-logo" src={img} alt="Atomic Jolt Logo" />
        <Wrapper
          className="c-user"
          onSelection={handleSelection}
        >
          <Button className="c-username">
            <span>{props.userName}</span>
            <i className="i-dropdown" />
          </Button>
          <Menu className="c-dropdown">
            <ul>
              <li>
                <MenuItem
                  value={props.signOutUrl}
                  text="Logout"
                  className="c-menu-item"
                >
                  <a href={props.signOutUrl}><span>Logout</span></a>
                </MenuItem>
              </li>
              <li>
                <MenuItem
                  value={`${props.signOutUrl}?destroy_authentications=true`}
                  text="Delete"
                  className="c-menu-item"
                >
                  <a href={`${props.signOutUrl}?destroy_authentications=true`}>
                    <span>Delete Canvas Authentications and Sign Out</span>
                  </a>
                </MenuItem>
              </li>
            </ul>
          </Menu>
        </Wrapper>
      </header>
      <SubNav />
    </div>
  );
}

Heading.propTypes = {
  backTo: React.PropTypes.string,
  userName: React.PropTypes.string,
  signOutUrl: React.PropTypes.string.isRequired,
};


export default connect(select)(Heading);
