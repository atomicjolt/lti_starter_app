import React from 'react';
import TestRenderer from 'react-test-renderer';
import _ from 'lodash';
import CourseInstallRow from './course_install_row';

describe('lti installs course install row', () => {

  let result;
  let props;
  const courseId = 123;
  const courseName = 'courseName';
  const installedToolId = 12;

  beforeEach(() => {
    props = {
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
    result = TestRenderer.create(<CourseInstallRow {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders row', () => {
    const courseTitle = instance.findByType('.c-table--inactive');
    expect(courseTitle.props().children).toEqual(
      <a href="example.com/courses/123/external_tools/12" rel="noopener noreferrer" target="_blank">courseName</a>
    );
  });

  it('renders buttons', () => {
    const installButton = instance.findByType('button');
    expect(installButton.props().children).toBe('Uninstall');
  });

  it('renders link without external tool', () => {
    const tempProps = _.cloneDeep(props);
    delete tempProps.installedTool;
    result = TestRenderer.create(<CourseInstallRow {...tempProps} />);
    const link = instance.findByType('a');
    expect(link).toBeDefined();
    const installLink = `example.com/courses/${props.courseId}`;
    const found = _.includes(link.props().href, installLink);
    expect(found).toBe(true);
  });

  it('renders link with external tool', () => {
    const link = instance.findByType('a');
    expect(link).toBeDefined();
    const installLink = `example.com/courses/${props.courseId}/external_tools/${installedToolId}`;
    const found = _.includes(link.props().href, installLink);
    expect(found).toBe(true);
  });

});
