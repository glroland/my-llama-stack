pipeline 
{
   agent any
   
   options 
   {
      disableConcurrentBuilds()
      buildDiscarder(logRotator(numToKeepStr: '3'))
   }

   stages
   {
      stage('Prepare') 
      {
         steps 
         {
            sh '''
                    echo "PATH = ${PATH}"
                '''

            git branch: 'main', 
                url: 'https://github.com/glroland/my-llama-stack.git'
         }
      }

      stage('Prepare for LLama Stack Build') 
      {
         steps 
         {
            dir('target')
            {
               // recreate artifact directory
               deleteDir()
               sh 'pwd -P'

               // checkout llama stack source
               checkout scmGit(
                  branches: [[name: '*/main']],
                  extensions: [ cloneOption(shallow: true) ],
                  userRemoteConfigs: [[url: 'https://github.com/meta-llama/llama-stack.git']])
               
               // install the dependencies
               sh 'uv pip install -e .'
            }

            // copy new template over to llama stack distro templates
            sh 'cp -Rp my-llama-stack-template target/llama_stack/templates/'
         }
      }

      stage('Build Llama Stack Image') 
      {
         steps 
         {
            dir('target')
            {
               sh 'lama stack build --template my-llama-stack-template --image-type container'
            }
         }
      }

      stage('Publish Llama Stack Image') 
      {
         steps 
         {
            sh 'docker tag my-llama-stack:0.2.7 my-llama-stack:$BUILD_NUMBER'
            sh 'docker save my-llama-stack:$BUILD_NUMBER > my-llama-stack-dockerimage.tar'
            step(followSymlinks: false, artifacts: 'my-llama-stack-dockerimage.tar', $class: 'ArtifactArchiver')
            sh 'docker rmi my-llama-stack:$BUILD_NUMBER'
            sh 'docker rmi my-llama-stack:0.2.7'
         }
      }

      stage('Reload then push images to quay') 
      {
         steps 
         {
            script 
            {
               docker.withRegistry('https://registry.home.glroland.com/', 'quay') 
               {
                  sh 'docker load -i my-llama-stack-dockerimage.tar'
                  sh 'docker tag my-llama-stack:$BUILD_NUMBER registry.home.glroland.com/ai/my-llama-stack:$BUILD_NUMBER'
                  sh 'docker rmi my-llama-stack:$BUILD_NUMBER'
                  sh 'docker push registry.home.glroland.com/ai/my-llama-stack:$BUILD_NUMBER'
                  sh 'docker rmi registry.home.glroland.com/ai/my-llama-stack:$BUILD_NUMBER'
               }
            }
         }
      }
   }
}
