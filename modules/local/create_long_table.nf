process CREATE_LONG_TABLE {
    tag "$meta.id"

    conda (params.enable_conda ? "conda-forge::python=3.9.5 conda-forge::matplotlib=3.5.1 conda-forge::pandas=1.3.5 conda-forge::r-sys=3.4 conda-forge::regex=2021.11.10 conda-forge::scipy=1.7.3" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/mulled-v2-77320db00eefbbf8c599692102c3d387a37ef02a:08144a66f00dc7684fad061f1466033c0176e7ad-0' :
        'quay.io/biocontainers/mulled-v2-77320db00eefbbf8c599692102c3d387a37ef02a:08144a66f00dc7684fad061f1466033c0176e7ad-0' }"

    input:
    path ('variants_table/*')
    path ('snpsift/*')
    path ('pangolin/*')

    output:
    path "variants_long_table.csv", optional:true, emit: csv_variants

    script:
    def args = task.ext.args ?: ''
    """
    create_long_table.py --samples_path ./variants_table --snpsift_path ./snpsift --pangolin_path ./pangolin $args

    """
}
