import React              from 'react';
import TestUtils          from 'react-addons-test-utils';
import { Provider }       from 'react-redux';
import _ from 'lodash';
import Helper             from '../../../../specs_support/helper';
import CourseInstallRow   from './course_install_row';

describe('lti installs course install row', () => {

  let result;
  const courseId = 123;
  const courseName = 'courseName';
  const installedToolId = 12;

  const props = {
    applicationInstance: {
      name: 'application_name',
      lti_key: 'lti_key',
      lti_secret: 'lti_secret',
      lti_config_xml: 'lti_config_xml',
      site: {
        url: 'example.com'
      }
    },
    installedTool: {
      id: installedToolId,
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
    const courseTitle = TestUtils.findRenderedDOMComponentWithClass(result, 'c-table--inactive');
    expect(courseTitle.textContent).toBe(courseName);
  });

  it('renders buttons', () => {
    const installButton = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
    expect(installButton.textContent).toBe('Uninstall');
  });

  it('renders link without external tool', () => {
    const tempProps = _.cloneDeep(props);
    delete tempProps.installedTool;
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <table>
          <tbody>
            <CourseInstallRow {...tempProps} />
          </tbody>
        </table>
      </Provider>
    );
    const link = TestUtils.findRenderedDOMComponentWithTag(result, 'a');
    expect(link).toBeDefined();
    const installLink = `example.com/courses/${props.courseId}`;
    const found = _.includes(link.href, installLink);
    expect(found).toBe(true);
  });

  it('renders link with external tool', () => {
    const link = TestUtils.findRenderedDOMComponentWithTag(result, 'a');
    expect(link).toBeDefined();
    const installLink = `example.com/courses/${props.courseId}/external_tools/${installedToolId}`;
    const found = _.includes(link.href, installLink);
    expect(found).toBe(true);
  });

});
