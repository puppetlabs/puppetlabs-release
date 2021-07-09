component 'repo_definition' do |pkg, _, platform|
  pkg.version '2021.07.09'

  if platform.is_deb?
    pkg.url 'file://files/pl-build-tools.list.txt'
    pkg.md5sum 'c9fa2a46a12cc95f536751870a76a87f'
    pkg.install_file 'pl-build-tools.list.txt', '/etc/apt/sources.list.d/pl-build-tools.list'
    pkg.install do
      if platform.is_huaweios?
        # For pl-build-tools, we're using jessie packages cross compiled for powerpc
        "sed -i 's|__CODENAME__|jessie|g' /etc/apt/sources.list.d/pl-build-tools.list"
      else
        "sed -i 's|__CODENAME__|#{platform.codename}|g' /etc/apt/sources.list.d/pl-build-tools.list"
      end
    end
  else
    # Specifying the repo path as a platform config var is likely the
    # way to go if anything else needs to get added here:
    if platform.is_cisco_wrlinux?
      repo_path = '/etc/yum/repos.d'
    elsif platform.is_sles?
      repo_path = '/etc/zypp/repos.d'
    else
      repo_path = '/etc/yum.repos.d'
    end

    install_cmds = []

    install_cmds << "sed -i " \
                    "-e 's|__OS_NAME__|#{platform.os_name}|g' " \
                    "-e 's|__OS_VERSION__|#{platform.os_version}|g' " \
                    "#{repo_path}/pl-build-tools.repo"

    if platform.is_sles?
      # Most yum-based systems will allow multiple gpg keys, like this:
      #
      #    gpgkey=file:///some-file
      #           file:///some-other-file
      #           file:///ya-file
      #
      # SLES does not allow it. We'll delete all but the first one.
      # Rearranging that over time will be needed.
      install_cmds << "sed -i -e '\\|^  *file:///|d' #{repo_path}/pl-build-tools.repo"
    end

    pkg.url 'file://files/pl-build-tools.repo.txt'
    pkg.md5sum '4723dc127409d5528b7814c0a1b338f9'
    pkg.install_file 'pl-build-tools.repo.txt', "#{repo_path}/pl-build-tools.repo"
    pkg.install do
      install_cmds
    end
  end
end
