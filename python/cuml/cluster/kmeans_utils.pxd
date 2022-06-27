#
# Copyright (c) 2019-2022, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import ctypes
from libcpp cimport bool
from libc.stdint cimport uint64_t
from cuml.metrics.distance_type cimport DistanceType

cdef extern from "raft/random/rng_state.hpp" namespace \
        "raft::random":
    enum GeneratorType:
        GenPhilox, GenPC

    cdef struct RngState:
        RngState(uint64_t seed) except +
        uint64_t seed,
        uint64_t base_subsequence,
        GeneratorType type

cdef extern from "cuml/cluster/kmeans.hpp" namespace \
        "ML::kmeans::KMeansParams":
    enum InitMethod:
        KMeansPlusPlus, Random, Array

    cdef struct KMeansParams:
        int n_clusters,
        InitMethod init
        int max_iter,
        double tol,
        int verbosity,
        RngState rng_state,
        DistanceType metric,
        int n_init,
        double oversampling_factor,
        int batch_samples,
        int batch_centroids,
        bool inertia_check
