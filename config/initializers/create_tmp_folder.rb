tmp_folder = File.join(Dir.tmpdir, 'designs')
public_folder = File.join(Rails.root, 'public')

FileUtils.mkdir(tmp_folder) unless Dir.exists?(tmp_folder)
FileUtils.ln_sf(tmp_folder, public_folder)
