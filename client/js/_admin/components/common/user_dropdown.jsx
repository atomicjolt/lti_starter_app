import React      from 'react';
import Item       from './drop_down_item';

export default function settingDropDown(props) {
  const styles = {
    settingsDropDown: {
      display         : 'inline-block',
      backgroundColor : 'white',
      fontSize        : '2em',
      position        : 'absolute',
      right           : '10px',
      top             : '75%',
      border          : '1px solid black',
      borderRadius    : '5px',
      padding         : '5px',
    },
  };

  return (
    <ul style={styles.settingsDropDown}>
      <Item><a href={props.signOutUrl}>Sign Out</a></Item>
      <Item><a href={ `${props.signOutUrl}?destroy_authentications=true` }>Delete Canvas Authentications and Sign Out</a></Item>
    </ul>
  );
}

settingDropDown.propTypes = {
  signOutUrl: React.PropTypes.string.isRequired,
};

