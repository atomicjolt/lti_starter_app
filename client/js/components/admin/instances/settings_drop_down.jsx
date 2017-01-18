import React      from 'react';

export default function settingDropDown(props) {
  const styles = {
    settingsDropDown: {
      display         : 'inline-block',
      backgroundColor : 'lightgrey',
      fontSize        : '2em',
      position        : 'absolute',
      border          : '1px solid black',
      borderRadius    : '5px',
      padding         : '5px',
    },
    settingsOption: {

    },
  };

  return (
    <ul style={styles.settingsDropDown}>
      <li style={styles.settingsOption}>Settings</li>
      <li style={styles.settingsOption}>Other Settings</li>
      <li style={styles.settingsOption}>More Settings</li>
    </ul>
  );
}

settingDropDown.propTypes = {

};
