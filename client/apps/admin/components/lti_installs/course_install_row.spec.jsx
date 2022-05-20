import React from 'react';
import TestRenderer from 'react-test-renderer';
import _ from 'lodash';
import CourseInstallRow from './course_install_row';

describe('lti installs course install row', () => {

  let result;
  let instance;
  const courseId = 123;
  const courseName = 'courseName';
  const installedToolId = 12;

  const applicationInstance = {
    name: 'application_name',
    lti_key: 'lti_key',
    lti_secret: 'lti_secret',
    lti_config_xml: 'lti_config_xml',
    site: {
      url: 'example.com'
    }
  };
  const installedTool = {
    id: installedToolId
  };
  const canvasRequest = () => {};

  beforeEach(() => {
    result = TestRenderer.create(
      <CourseInstallRow
        applicationInstance={applicationInstance}
        installedTool={installedTool}
        canvasRequest={canvasRequest}
        courseName={courseName}
        courseId={courseId}
      />);
    instance = result.root;
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders row', () => {
    const a = instance.findByType('a');
    expect(a.props.href).toEqual('example.com/courses/123/external_tools/12');
  });

  it('renders buttons', () => {
    const installButton = instance.findByType('button');
    expect(installButton.props.children).toBe('Uninstall');
  });

  it('renders link without external tool', () => {
    result = TestRenderer.create(
      <CourseInstallRow
        applicationInstance={applicationInstance}
        canvasRequest={canvasRequest}
        courseName={courseName}
        courseId={courseId}
      />);
    const link = instance.findByType('a');
    expect(link).toBeDefined();
    const installLink = `example.com/courses/${courseId}`;
    const found = _.includes(link.props.href, installLink);
    expect(found).toBe(true);
  });

  it('renders link with external tool', () => {
    const link = instance.findByType('a');
    expect(link).toBeDefined();
    const installLink = `example.com/courses/${props.courseId}/external_tools/${installedToolId}`;
    const found = _.includes(link.props.href, installLink);
    expect(found).toBe(true);
  });

});
