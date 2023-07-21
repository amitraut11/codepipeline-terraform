terraform{
    backend "s3" {
        bucket = "terraformbucketcicd"
        encrypt = true
        key = "terraform.tfstate"
        region = "us-east-1"
        
    }
}

provider "aws" {
    region = "us-east-1"
    access_key = "AKIAVKCN75EWQKI7XY4G"
    secret_key = "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"
}