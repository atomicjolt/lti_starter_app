import React          from 'react';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';

export default function InstallPane(props) {
  return (
    <div className="o-right">
      <AccountInstall
        accountName={props.currentAccount.name}
        accountInstalls={props.currentAccount.installCount}
      />
      <div className="c-search c-search--small">
        <input type="text" placeholder="Search..." />
        <i className="i-search" />
      </div>

      <CourseInstalls courses={props.courses} />
    </div>
  );
}

InstallPane.propTypes = {
  currentAccount: React.PropTypes.shape({
    name: React.PropTypes.string,
    installCount: React.PropTypes.number
  }).isRequired,
  courses: React.PropTypes.arrayOf(React.PropTypes.shape({})).isRequired
};

InstallPane.defaultProps = {
  currentAccount: {}
};
