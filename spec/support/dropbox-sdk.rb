require_relative "vcr"

class DropboxSession
  attr_reader :consumer_key, :consumer_secret
end

class DropboxClient
  attr_reader :session, :root

  def self.uploaded_files
    @uploaded_files ||= []
  end

  alias normal_put_file put_file
  def put_file(path, file, *args)
    self.class.uploaded_files << [path, self]
    normal_put_file(path, file, *args)
  end

  alias normal_file_delete file_delete
  def file_delete(path, *args)
    self.class.uploaded_files.delete_if { |p, _| p == path }
    normal_file_delete(path, *args)
  end
end

