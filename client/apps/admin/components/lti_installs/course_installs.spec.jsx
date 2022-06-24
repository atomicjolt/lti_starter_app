import React from 'react';
import TestRenderer from 'react-test-renderer';
import CourseInstalls from './course_installs';

describe('lti installs course install', () => {
  let result;
  const courseId = 123;
  let instance;
  let changed;

  const applicationInstance = {
    name: 'application_name',
    lti_key: 'lti_key',
    lti_secret: 'lti_secret',
    lti_config_xml: 'lti_config_xml',
  };
  const canvasRequest = () => {};
  const onlyShowInstalledChanged = () => { changed = true; };
  const loadingCourses = {
    courseName: 'name',
    courseId: 'id',
  };
  const courses = [];
  const installedTool = {
    id: 12,
  };
  const courseName = 'courseName';

  beforeEach(() => {
    result = TestRenderer.create(<CourseInstalls
      applicationInstance={applicationInstance}
      canvasRequest={canvasRequest}
      onlyShowInstalledChanged={onlyShowInstalledChanged}
      loadingCourses={loadingCourses}
      courses={courses}
      installedTool={installedTool}
      courseName={courseName}
      courseId={courseId}
    />);
    instance = result.root;
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders buttons', () => {
    const courseNameSpan = instance.findByType('span');
    expect(courseNameSpan.props.children).toBe('Course Name');
  });

  // Remove the checkbox so removing the test for now
  // it('handles the onChange for input', () => {
  //   expect(changed).toBeFalsy();
  //   const input = instance.findByType('input');
  //   input.simulate('change');
  //   expect(changed).toBeTruthy();
  // });
});
