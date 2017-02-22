import React              from 'react';
import TestUtils          from 'react-addons-test-utils';
import { Provider }       from 'react-redux';
import Helper             from '../../../../specs_support/helper';
import CourseInstallRow   from './course_install_row';

describe('lti installs course install row', () => {

  let result;
  const courseId = 123;
  const courseName = 'courseName';

  var props = {
    applicationInstance: {
      name: 'application_name',
      lti_key: 'lti_key',
      lti_secret: 'lti_secret',
      lti_config_xml: 'lti_config_xml',
    },
    installedTool: {
      id: 12
    },
    canvasRequest: () => {},
    courseName,
    courseId,
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <table><tbody>
          <CourseInstallRow {...props} />
        </tbody></table>
      </Provider>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('renders row', () => {
    const courseName = TestUtils.findRenderedDOMComponentWithClass(result, 'c-table--inactive');
    expect(courseName.textContent).toBe(courseName);
  });

  it('renders buttons', () => {
    const installButton = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
    expect(installButton.textContent).toBe('Uninstall');
  });

});
