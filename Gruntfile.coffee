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

	grunt.loadNpmTasks('grunt-contrib-coffee')

	grunt.registerTask('default',['coffee'])