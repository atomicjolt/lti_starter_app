import React from 'react';

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
      <li>Settings</li>
      <li>Other Settings</li>
      <li>More Settings</li>
    </ul>
  );
}

settingDropDown.propTypes = {

};
