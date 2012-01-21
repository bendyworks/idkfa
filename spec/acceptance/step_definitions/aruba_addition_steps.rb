step "the file :file should contain:" do |file, partial_content|
  check_file_content(file, partial_content, true)
end
