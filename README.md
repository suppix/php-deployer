# php-deployer

Docker image of https://deployer.org with ssh, git, composer and the latest contrib recipes.

Example:

deploy.php
```
<?php
namespace Deployer;

require 'recipe/common.php';
require 'contrib/telegram.php';

set('telegram_token', getenv('TELEGRAM_TOKEN'));
set('telegram_chat_id', getenv('TELEGRAM_CHAT_ID'));

// Project name
set('application', 'promo');

// Project repository
set('repository', 'ssh://git@git.domain.com/group/repo.git');

// [Optional] Allocate tty for git clone. Default value is false.
set('git_tty', true);

// Shared files/dirs between deploys
set('shared_files', ['data/config.inc.php']);
set('shared_dirs', ['www/files']);

// Writable dirs by web server
set('writable_dirs', ['data/tpl_cache', 'data/templates_c', 'www/files']);
set('allow_anonymous_stats', false);

// Hosts

host('domain.com')
    ->set('remote_user', 'promo')
    ->set('hostname', 'domain.com')
    ->set('labels', ['stage' => 'production'])
    ->set('deploy_path', '~/{{application}}');

// Tasks

desc('Deploy your project');
task('deploy', [
    'deploy:prepare',
    'deploy:publish',
]);

// [Optional] If deploy fails automatically unlock.
after('deploy:failed', 'deploy:unlock');
after('deploy:failed', 'telegram:notify:failure');

after('deploy:success', 'telegram:notify:success');
```
