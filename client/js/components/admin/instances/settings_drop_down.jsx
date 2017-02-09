import React      from 'react';
import Item       from './drop_down_item';

export default function settingDropDown() {
  const styles = {
    settingsDropDown: {
      display         : 'inline-block',
      backgroundColor : 'white',
      fontSize        : '2em',
      position        : 'absolute',
      border          : '1px solid black',
      borderRadius    : '5px',
      padding         : '5px',
    },
  };

  return (
    <ul style={styles.settingsDropDown}>
      <Item>Settings</Item>
      <Item>Other Settings</Item>
      <Item>More Settings</Item>
    </ul>
  );
}

settingDropDown.propTypes = {

};
