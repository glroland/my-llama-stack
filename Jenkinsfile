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

      stage('Build Llama Stack Image') 
      {
         steps 
         {
            sh 'build.sh'
         }
      }

      stage('Publish Llama Stack Image') 
      {
         steps 
         {
            sh 'docker tag my-llama-stack:0.2.5 my-llama-stack:$BUILD_NUMBER'
            sh 'docker rmi my-llama-stack:0.2.5'
            sh 'docker save registry.home.glroland.com/ai/my-llama-stack:$BUILD_NUMBER > my-llama-stack-dockerimage.tar'
            step(followSymlinks: false, artifacts: 'my-llama-stack-dockerimage.tar', $class: 'ArtifactArchiver')
            sh 'docker rmi my-llama-stack:$BUILD_NUMBER'
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
                  sh 'docker rmi rregistry.home.glroland.com/ai/my-llama-stack:$BUILD_NUMBER'
               }
            }
         }
      }
   }
}
