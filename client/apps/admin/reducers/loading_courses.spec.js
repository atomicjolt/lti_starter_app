import loadingCourses from './loading_courses';

describe('loading_courses reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = loadingCourses(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('list external tools courses', () => {
    it('returns localDataId to be true', () => {
      const localDataId = 2;
      const state = { loading_courses: [{ 1: { id: 1, config: 123 } }], 2: false };
      const result = loadingCourses(state, { type: 'LIST_EXTERNAL_TOOLS_COURSES', localData: localDataId });
      expect(result.loading_courses.length).toBe(1);
      expect(result[localDataId]).toBe(true);
    });
  });

  describe('delete external tools courses', () => {
    it('returns the same state', () => {
      const localDataId = 2;
      const state = { loading_courses: [{ 1: { id: 1, config: 123 } }], 2: false };
      const result = loadingCourses(state, { type: 'LIST_EXTERNAL_TOOLS_COURSES_DONE', original: { localData: localDataId } });
      expect(result.loading_courses.length).toBe(1);
      expect(result[localDataId]).not.toBeDefined();
    });
  });
});
