module.exports = (grunt)->

	grunt.initConfig
		coffee:
			compile:
				files:
					"./index.js": "./index.coffee"

			glob_to_multiple:
				expand: true,
				flatten: true,
				cwd: './src/',
				src: ['*.coffee'],
				dest: './lib',
				ext: '.js'

		watch:
			files: ['./src/*.coffee']
			tasks: ['coffee']
			
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.registerTask('default',['coffee'])