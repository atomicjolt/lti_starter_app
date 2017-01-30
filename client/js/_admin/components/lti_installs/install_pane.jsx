import React          from 'react';
import AccountInstall from './account_install';
import CourseInstalls from './course_installs';

export default function InstallPane(props) {
  return (
    <div className="o-right">
      <AccountInstall
        accountName={props.account ? props.account.name : 'Root'}
        accountInstalls={props.account ? props.account.installCount : null}
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
  account: React.PropTypes.shape({
    name: React.PropTypes.string,
    installCount: React.PropTypes.number
  }),
  courses: React.PropTypes.shape({}).isRequired,
};

