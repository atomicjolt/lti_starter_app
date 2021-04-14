module StorageSupport

  protected

  def copy_to_storage(file, filename, dirs = ["job"])
    duplicate_dir_path = File.join([Dir.tmpdir, dirs].flatten)

    FileUtils.mkdir_p(duplicate_dir_path)
    duplicate_file_path = File.join(duplicate_dir_path, filename)
    pid = spawn("/bin/mv", file.path, duplicate_file_path)
    success = Process.wait(pid)
    raise Exceptions::FileMvException unless success
    file.close
    duplicate_file_path
  end
end
